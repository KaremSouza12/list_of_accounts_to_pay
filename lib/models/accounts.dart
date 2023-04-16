class Account {
  final int? id;
  String title;
  String dueDate;
  bool? status;

  Account(
      {this.id,
      required this.title,
      required this.dueDate,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'duedate': dueDate,
      'status': status == true ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'Account{id:$id,title: $title, dueDate: $dueDate,status: $status}';
  }
}
