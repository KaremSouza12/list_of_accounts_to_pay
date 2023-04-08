class Account {
  String title;
  String dueDate;

  Account({required this.title, required this.dueDate});

  Map<String, dynamic> toMap() {
    return {'title': title, 'duedate': dueDate};
  }

  // List<Account> list(){

  // }

  @override
  String toString() {
    return 'Account{title: $title, dueDate: $dueDate}';
  }
}
