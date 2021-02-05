import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:treat_yoself/utils/database/sql_queries.dart';
part 'sql_query_group.g.dart';

@JsonSerializable()
class SQLQueryGroup {
  final String type;
  final List<SQLQueryString> queries;
  SQLQueryGroup({this.type, this.queries});

  factory SQLQueryGroup.fromJson(Map<String, dynamic> data) =>
      _$SQLQueryGroupFromJson(data);

  Map<String, dynamic> toJson() => _$SQLQueryGroupToJson(this);

  String GetQueryGroup(String table) {
    var tableMatch =
        queries.firstWhere((table) => table.getTableName() == table);
    return tableMatch.getQueryString();
  }

  String GetType() {
    return type;
  }
}
