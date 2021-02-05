import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'sql_queries.g.dart';

@JsonSerializable()
class SQLQueryString {
  final String table;
  final String query;
  SQLQueryString({this.table, this.query});

  factory SQLQueryString.fromJson(Map<String, dynamic> data) =>
      _$SQLQueryStringFromJson(data);

  Map<String, dynamic> toJson() => _$SQLQueryStringToJson(this);

  String getTableName() {
    return table;
  }

  String getQueryString() {
    return query;
  }
}
