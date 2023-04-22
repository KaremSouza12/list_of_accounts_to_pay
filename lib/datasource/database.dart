import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    return db.execute(_account);
  }

  String get _account =>
      '''CREATE TABLE account_pay (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, dueDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, status INTEGER NOT NULL, valueAccount REAL )''';

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
