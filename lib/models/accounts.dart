class Account {
  int? id;
  String? title;
  String? dueDate;
  bool? status;
  double? valueAccount;

  Account({
    this.id,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.valueAccount,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'duedate': dueDate,
  //     'status': status == true ? 1 : 0,
  //     'valueAccount': valueAccount
  //   };
  // }

  Account.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    dueDate = map['dueDate'];
    status = map['status'] == 1;
    valueAccount = map['valueAccount'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['dueDate'] = dueDate;
    data['status'] = status == true ? 1 : 0;
    data['valueAccount'] = valueAccount;
    return data;
  }

  @override
  String toString() {
    return 'Account{id:$id,title: $title, dueDate: $dueDate,status: $status, valueAccount:$valueAccount}';
  }
}
