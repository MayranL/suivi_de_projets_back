import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User extends Equatable {
  User({
    this.id,
    this.name,
    this.surname,
    this.role,
    this.email,
    this.password,
  });

  final String? id;
  final String? name;
  final String? surname;
  final String? role;
  final String? email;
  final String? password;

  User copyWith({
    String? id,
    String? name,
    String? surname,
    String? role,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, name, surname, role, email, password];
}
