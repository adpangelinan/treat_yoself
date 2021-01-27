// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sql_query_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SQLQueryGroup _$SQLQueryGroupFromJson(Map<String, dynamic> json) {
  return SQLQueryGroup(
    type: json['type'] as String,
    queries: (json['queries'] as List)
        ?.map((e) => e == null
            ? null
            : SQLQueryString.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SQLQueryGroupToJson(SQLQueryGroup instance) =>
    <String, dynamic>{
      'type': instance.type,
      'queries': instance.queries,
    };
