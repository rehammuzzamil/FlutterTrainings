import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:assignment5/model/WordPairData.dart';

const String tableName = 'WordPair';
const String idColumn = 'id';
const String firstNameColumn = "firstName";
const String secondNameColumn = "secondName";
const String isSaved = 'isSaved';

class PersistentWordPairProvider {
  Database db;

  PersistentWordPairProvider();

  Future _open() async {
    final databasesPath = await getDatabasesPath();
    String path = '$databasesPath/db.db';
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        return await db.execute(
          '''
          create table $tableName ( 
            $idColumn integer primary key autoincrement, 
            $firstNameColumn text not null,
            $secondNameColumn text not null,
            $isSaved bool not null)
          ''',
        );
      },
    );
  }

  Future<List<int>> batchInsert(List<WordPairData> pairs) async {
    await _open();
    final batch = db.batch();
    pairs.forEach((pair) {
      batch.insert(tableName, pair.toMap());
    });
    final result = await batch.commit();
    print('Result of batch insert: $result');
    await _close();
    return result
        .toList()
        .map(
          (item) => int.parse(item.toString()),
    )
        .toList();
  }

  Future<List<WordPairData>> getAll() async {
    await _open();
    List<Map> maps = await db.rawQuery(
      'SELECT * FROM $tableName ORDER BY $idColumn',
    );
    List<WordPairData> result = [];
    if (maps.length > 0) {
      result = maps.map((map) => WordPairData.fromMap(map)).toList();
    }
    await _close();
    return result;
  }

  Future<List<WordPairData>> getDataWithIDs(List<int> idList) async {
    await _open();
    List<Map> maps = await db.rawQuery(
      """
      SELECT * 
      FROM $tableName 
      WHERE $idColumn IN (${idList.join(', ')})
      ORDER BY $idColumn
      """,
    );
    List<WordPairData> result = [];
    if (maps.length > 0) {
      result = maps.map((map) => WordPairData.fromMap(map)).toList();
    }
    await _close();
    return result;
  }

  Future<int> updateSaved(WordPairData data) async {
    await _open();
    var result = await db.rawUpdate("""
        UPDATE $tableName 
        SET $isSaved = ${data.saved ? '1' : '0'} 
        WHERE $idColumn = ${data.id}
        """);
    await _close();
    print('Result of updateSaved: $result');
    return result;
  }

  Future _close() async => db.close();
}
