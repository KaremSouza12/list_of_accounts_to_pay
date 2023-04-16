import 'package:flutter/material.dart';
import 'package:pay_count/datasource/database.dart';
import 'package:pay_count/models/accounts.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountsRepository extends ChangeNotifier {
  late Database db;
  List<Account> _accounts = [];

  List<Account> get accounts => _accounts;

  AccountsRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getAccount();
  }

  _getAccount() async {
    db = await DB.instance.database;
    final List<Map<String, dynamic>> data = await db.query(
      'accounts',
    );
    _accounts = List.generate(
      data.length,
      (i) {
        return Account(
          id: data[i]['id'],
          title: data[i]['title'],
          dueDate: data[i]['dueDate'],
          status: data[i]['status'] == 1,
        );
      },
    );
    notifyListeners();
  }

  createData(Account account) async {
    db = await DB.instance.database;
    final id = db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _getAccount();
    notifyListeners();
    return id;
  }

  deleteAll() async {
    db = await DB.instance.database;
    await db.execute("DROP TABLE IF EXISTS accounts");
    _getAccount();
    notifyListeners();
  }

  getItem(int? id) async {
    final db = await DB.instance.database;
    final info = await db.query('accounts', where: "id=?", whereArgs: [id]);
    print(info);
  }

  updateItem(int? id, int? status) async {
    final db = await DB.instance.database;

    await db
        .rawUpdate('UPDATE accounts SET status = ? WHERE id = ?', [status, id]);
    notifyListeners();
    _getAccount();
  }

  deleteItem(int? id) async {
    final db = await DB.instance.database;

    await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
    _getAccount();
  }
}
