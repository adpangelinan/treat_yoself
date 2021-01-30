// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sql_queries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SQLQueryString _$SQLQueryStringFromJson(Map<String, dynamic> json) {
  return SQLQueryString(
    table: json['table'] as String,
    query: json['query'] as String,
  );
}

Map<String, dynamic> _$SQLQueryStringToJson(SQLQueryString instance) =>
    <String, dynamic>{
      'table': instance.table,
      'query': instance.query,
    };
