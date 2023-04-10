const String createAccountTableScript =
    'CREATE TABLE accounts (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, dueDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, status INTEGER NOT NULL)';

class DatabaseScripts {
  static String createAccountsTable() {
    return createAccountTableScript;
  }
}
