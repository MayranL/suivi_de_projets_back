import 'dart:async';

import 'package:postgres/postgres.dart';
import 'package:suivi_de_projets_back_data_source/suivi_de_projets_back_data_source.dart';
import 'package:uuid/uuid.dart';


/// An database implementation of the [UserDataSource] interface.
class DatabaseUser implements UserDataSource {
  /// Connect the database-> user
  final conn = PostgreSQLConnection('localhost', 5432, 'postgres',
      username: 'postgres', password: 'postgres');

  Future<bool> isConnectionOpen() async {
    final connection = conn;

    if (connection.isClosed){
      await connection.open();
      return true;
    }
    return true;
  }


  @override
  Future<User> create(User user) async {
    await isConnectionOpen();

    final uuid = const Uuid().v4();
    final id = uuid.hashCode;

    final createdUser = user.copyWith(id: id.toString());

    final results = await conn.query(
      'INSERT INTO "user" (name, surname, role, email, password)'
          'VALUES (@name, @surname, @role, @email, @password) RETURNING *',
      substitutionValues: {
        'name': createdUser.name,
        'surname': createdUser.surname,
        'role': createdUser.role,
        'email': createdUser.email,
        'password': createdUser.password,
      },
    );

    User user2 = User(
      id: results.single[0],
      name: results.single[1],
      surname: results.single[2],
      role: results.single[3],
      email: results.single[4],
      password: results.single[5],
    );

    return user2;
  }



  @override
  Future<List<User>> readAll() async {
    await isConnectionOpen();
    final results = await conn.query('SELECT * FROM "user"');

    final users = results.map((row) => User(
      id: row[0] as String?,
      name: row[1] as String?,
      surname: row[2] as String?,
      role: row[3] as String?,
      email: row[4] as String?,
      password: row[5] as String?,
    )).toList();
    return users;
  }



  @override
  Future<User?> read(String id) async {
    await isConnectionOpen();

    final results = await conn.query(
      'SELECT * FROM user WHERE id = @id',
      substitutionValues: {'id': id},
    );

    if (results.isNotEmpty) {
      final user = User(
        id: results.single[2],
        name: results.single[0],
        email: results.single[1],
        surname: results.single[3],
      );
      return user;
    } else {
      return null; // Aucun élément trouvé
    }
  }


  @override
  Future<User> update(String id, User user) async {
    await isConnectionOpen();

    await conn.query(
      'UPDATE user SET name = @name, role = @role, email = @email, surname = @surname, password = @password '
          'WHERE id = @id',
      substitutionValues: {
        'id': id,
        'name': user.name,
        'surname': user.surname,
        'role': user.role,
        'email': user.email,
        'password': user.password,
      },
    );

    return user;
  }


  @override
  Future<void> delete(String id) async {
    await isConnectionOpen();

    await conn.query(
      'DELETE FROM user WHERE id = @id',
      substitutionValues: {'id': id},
    );
  }
}