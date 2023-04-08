import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_script.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        'pay_count.db',
      ),
      onCreate: _onCreate,
      version: 1,
    );
  }

  _onCreate(db, version) {
    return db.execute(
      DatabaseScripts.createAccountsTable(),
    );
  }

  // static Future<void> insertAccounts(Account account) async {
  //   try {
  //     final Database db = await createDataBase();

  //     await db.insert(
  //       'accounts',
  //       account.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<List<Account>> getAccounts() async {
  //   final Database db = await createDataBase();
  //   final List<Map<String, dynamic>> data = await db.query('accounts');
  //   return List.generate(
  //     data.length,
  //     (i) {
  //       return Account(
  //         title: data[i]['title'],
  //         dueDate: data[i]['dueDate'],
  //       );
  //     },
  //   );
  // }
}
