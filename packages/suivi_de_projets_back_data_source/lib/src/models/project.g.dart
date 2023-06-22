// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as String?,
      status: json['status'] as String?,
      risk: json['risk'] as String?,
      imageUrl: json['imageUrl'] as String?,
      chef: json['chef'] == null
          ? null
          : Chef.fromJson(json['chef'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'risk': instance.risk,
      'imageUrl': instance.imageUrl,
      'chef': instance.chef,
    };
