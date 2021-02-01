///Collection of global functions for data manipulation and querying.
///
///

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mysql1/mysql1.dart';
import 'package:treat_yoself/utils/database/sql_controller.dart';

class DatabaseEngine {
  DatabaseEngine();
  SQLController sqlController;
  final dbConnectionString = ConnectionSettings(
      host: 'j21q532mu148i8ms.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
      port: 3306,
      user: 'dhfdwp5gwhpmvwz1',
      password: 'rbs034lkb2ecn4iu',
      db: 'athdy9ib33fbmfvk');

  Future<void> initialize() async {
    await buildSQLList();
    return;

    ///Add error message if connection to server cannot be made (no service)
  }

  /// Creates a SQLController object that is bound to the existing DatabaseEngine object.
  Future<void> buildSQLList() async {
    var queryString = await File('../lib/data/sql_queries.json').readAsString();
    var jsonData = json.decode(queryString);
    sqlController = SQLController.fromJson(jsonData);
  }

  /// Validates the SQL Query string and parameters.
  /// Passes them to the server, and returns any data passed back by the server.
  Future<List<String>> dbQuery(String type, String table,
      [List context]) async {
    var queryString = sqlController.getQuery(type, table);
    var result = await contactServer(queryString, [context]);
    return result;
  }

  /// Creates a connection to the SQL server and handles sending/receiving data.
  Future<List<String>> contactServer(String query, [List context]) async {
    final conn = await MySqlConnection.connect(dbConnectionString);
    var results = await conn.query(query, [context]);
    List<String> resultArray = [];
    for (var row in results) {
      resultArray.add(row.toString());
      print(row);
    }
    return resultArray;
  }
}
