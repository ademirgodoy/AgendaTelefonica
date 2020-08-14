import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:agendatelefonica/model/agenda.dart';
class DbHelper {
  String tblAgenda = "agenda";
  String colIdAgenda = "idagenda";
  String colNome = "nome";
  String colTelefone = "telefone";
  String colData = "data";

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path + tblAgenda + ".db";

    var dbAgenda = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbAgenda;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblAgenda($colIdAgenda INTEGER PRIMARY KEY, $colNome TEXT, " +
            "$colTelefone TEXT, $colData TEXT)");
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<int> insertAgenda(Agenda agenda) async {
    Database db = await this.db;
    var result = await db.insert(tblAgenda, agenda.toMap());
    return result;
  }

  Future<List> getAgenda() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblAgenda order by $colNome ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("select count (*) from $tblAgenda")
    );
    return result;
  }

  Future<int> updateAgenda(Agenda agenda) async {
    var db = await this.db;
    var result = await db.update(tblAgenda,
        agenda.toMap(),
        where: "$colIdAgenda = ?",
        whereArgs: [agenda.idAgenda]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete('DELETE FROM $tblAgenda WHERE $colIdAgenda = $id');
    return result;
  }

}