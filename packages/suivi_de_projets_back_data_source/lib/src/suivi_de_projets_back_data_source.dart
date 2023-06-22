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

/// An interface for a projects data source.
/// A projects data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class ProjectDataSource {
  /// Create and return the newly created project.
  Future<Project> create(Project project);

  /// Return all projects.
  Future<List<Project>> readAll();

  /// Return a project with the provided [id] if one exists.
  Future<Project?> read(String id);

  /// Update the project with the provided [id] to match [project] and
  /// return the updated project.
  Future<Project> update(String id, Project project);

  /// Delete the project with the provided [id] if one exists.
  Future<void> delete(String id);
}

/// An interface for a chefs data source.
/// A chefs data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete
abstract class ChefDataSource {
  /// Create and return the newly created chef.
  Future<Chef> create(Chef project);

  /// Return all chefs.
  Future<List<Chef>> readAll();

  /// Return a chef with the provided [id] if one exists.
  Future<Chef?> read(String id);

  /// Update the chef with the provided [id] to match [chef] and
  /// return the updated chef.
  Future<Chef> update(String id, Chef chef);

  /// Delete the chef with the provided [id] if one exists.
  Future<void> delete(String id);
}