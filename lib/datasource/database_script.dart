const String createAccountTableScript =
    "CREATE TABLE accounts(id INTEGER PRIMARY KEY,title TEXT, dueDate TEXT)";

class DatabaseScripts {
  static String createAccountsTable() {
    return createAccountTableScript;
  }
}
