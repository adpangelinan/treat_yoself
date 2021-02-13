///Collection of global functions for data manipulation and querying.
///
///

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:mysql1/mysql1.dart';

class DatabaseEngine {
  int insertID;

  DatabaseEngine();
  final dbConnectionString = ConnectionSettings(
      host: 'j21q532mu148i8ms.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
      port: 3306,
      user: 'dhfdwp5gwhpmvwz1',
      password: 'rbs034lkb2ecn4iu',
      db: 'athdy9ib33fbmfvk');

  Future<List<dynamic>> manualQuery(String queryString, [List context]) async {
    var results = await contactServer(queryString, context);
    var tabulatedResults = [];
    for (var row in results) {
      tabulatedResults.add(row);
    }
    return tabulatedResults;
  }

  /// Creates a connection to the SQL server and handles sending/receiving data.
  Future<List<dynamic>> contactServer(String query, [List context]) async {
    final conn = await MySqlConnection.connect(dbConnectionString);
    var results = await conn.query(query, context);
    insertID = results.insertId;
    List<dynamic> resultArray = [];
    print(results.toString());
    for (var row in results) {
      resultArray.add(row);
    }
    conn.close();
    return resultArray;
  }
}
