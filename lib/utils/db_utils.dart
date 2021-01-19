///Collection of global functions for data manipulation and querying.
///
///

import 'dart:async';

import 'package:mysql1/mysql1.dart';

final dbConnectionString = ConnectionSettings(
    host: 'j21q532mu148i8ms.cbetxkdyhwsb.us-east-1.rds.amazonaws.com',
    port: 3306,
    user: 'dhfdwp5gwhpmvwz1',
    password: 'rbs034lkb2ecn4iu',
    db: 'athdy9ib33fbmfvk');

final List<String> SQLQueries = ["SELECT "];

Future<List<String>> queryDB() async {
  final conn = await MySqlConnection.connect(dbConnectionString);
  var results = await conn.query('SELECT * FROM Comments');
  List<String> resultArray = [];
  for (var row in results) {
    resultArray.add('Comment: ${row[1]}, Date: ${row[2]}');
  }
  return resultArray;
}
