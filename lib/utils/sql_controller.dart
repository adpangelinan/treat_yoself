import 'package:json_annotation/json_annotation.dart';
import 'package:treat_yoself/utils/sql_query_group.dart';
part 'sql_controller.g.dart';

@JsonSerializable(explicitToJson: true)
class SQLController {
  final List<SQLQueryGroup> allQueries;

  SQLController({this.allQueries});
  factory SQLController.fromJson(Map<String, dynamic> data) =>
      _$SQLControllerFromJson(data);

  Map<String, dynamic> toJson() => _$SQLControllerToJson(this);

  String GetQuery(String type, String table) {
    var queryGroup = allQueries.firstWhere((group) => group.GetType() == type);
    return queryGroup.GetQueryGroup(table);
  }
}
