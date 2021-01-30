// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sql_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SQLController _$SQLControllerFromJson(Map<String, dynamic> json) {
  return SQLController(
    allQueries: (json['allQueries'] as List)
        ?.map((e) => e == null
            ? null
            : SQLQueryGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SQLControllerToJson(SQLController instance) =>
    <String, dynamic>{
      'allQueries': instance.allQueries?.map((e) => e?.toJson())?.toList(),
    };
