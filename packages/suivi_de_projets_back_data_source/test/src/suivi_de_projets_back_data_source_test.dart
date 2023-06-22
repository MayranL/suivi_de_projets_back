import 'package:suivi_de_projets_back_data_source/suivi_de_projets_back_data_source.dart';

/// An interface for a users data source.
/// A users data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class UserDataSource {
  /// Create and return the newly created user.
  Future<User> create(User user);

  /// Return all users.
  Future<List<User>> readAll();

  /// Return a user with the provided [id] if one exists.
  Future<User?> read(String id);

  /// Update the user with the provided [id] to match [user] and
  /// return the updated user.
  Future<User> update(String id, User user);

  /// Delete the user with the provided [id] if one exists.
  Future<void> delete(String id);
}