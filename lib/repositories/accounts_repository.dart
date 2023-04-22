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
      'account_pay',
    );

    _accounts = List.generate(
      data.length,
      (i) {
        return Account(
          id: data[i]['id'],
          title: data[i]['title'],
          dueDate: data[i]['dueDate'],
          status: data[i]['status'] == 1,
          valueAccount: data[i]['valueAccount'],
        );
      },
    );
    notifyListeners();
  }

  createData(Account account) async {
    db = await DB.instance.database;

    final id = await db.insert(
      'account_pay',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _getAccount();
    notifyListeners();
    return (id);
  }

  deleteAll() async {
    db = await DB.instance.database;
    await db.execute("DROP TABLE IF EXISTS account_pay");
    _getAccount();
    notifyListeners();
  }

  getItem(int? id) async {
    final db = await DB.instance.database;
    final info = await db.query('account_pay', where: "id=?", whereArgs: [id]);
    if (info.isNotEmpty) {
      return Account.fromMap(info.first);
    }

    return null;
  }

  updateStatus(int? id, int? status) async {
    final db = await DB.instance.database;

    await db.rawUpdate(
        'UPDATE account_pay SET status = ? WHERE id = ?', [status, id]);
    notifyListeners();
    _getAccount();
  }

  deleteItem(int? id) async {
    final db = await DB.instance.database;

    await db.delete(
      'account_pay',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
    _getAccount();
  }

  updateValues(
    int? id,
    String? title,
    String? dueDate,
    double? valueAccount,
    bool? status,
  ) async {
    final db = await DB.instance.database;

    final account = Account(
        id: id,
        title: title,
        dueDate: dueDate,
        status: status,
        valueAccount: valueAccount);
    db.update('account_pay', account.toMap(), where: 'id=?', whereArgs: [id]);
    notifyListeners();
    _getAccount();
  }
}
