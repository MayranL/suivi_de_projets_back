import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'chef.dart';

part 'project.g.dart';

@immutable
@JsonSerializable()
class Project extends Equatable {
  Project({
    this.id,
    this.status,
    this.risk,
    this.imageUrl,
    this.chef,
  });

  final String? id;
  final String? status;
  final String? risk;
  final String? imageUrl;
  final Chef? chef;

  Project copyWith({
    String? id,
    String? status,
    String? risk,
    String? imageUrl,
    Chef? chef,
  }) {
    return Project(
      id: id ?? this.id,
      status: status ?? this.status,
      risk: risk ?? this.risk,
      imageUrl: imageUrl ?? this.imageUrl,
      chef: chef ?? this.chef,
    );
  }

  static Project fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  List<Object?> get props => [id, status, risk, imageUrl, chef];
}