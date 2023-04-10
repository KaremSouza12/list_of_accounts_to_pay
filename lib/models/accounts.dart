class Account {
  String title;
  String dueDate;
  bool status;

  Account({required this.title, required this.dueDate, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duedate': dueDate,
      'status': status == true ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'Account{title: $title, dueDate: $dueDate,status: $status}';
  }
}
