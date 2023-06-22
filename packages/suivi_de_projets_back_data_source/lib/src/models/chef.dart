import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'chef.g.dart';

@immutable
@JsonSerializable()
class Chef extends Equatable {
  Chef({
    this.id,
    this.name,
    this.surname,
  });

  final String? id;
  final String? name;
  final String? surname;

  Chef copyWith({
    String? id,
    String? name,
    String? surname,
  }) {
    return Chef(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }

  static Chef fromJson(Map<String, dynamic> json) => _$ChefFromJson(json);

  Map<String, dynamic> toJson() => _$ChefToJson(this);

  @override
  List<Object?> get props => [id, name, surname];
}
