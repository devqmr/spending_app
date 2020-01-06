class Transaction {
  String id;
  String title;
  double amount;
  DateTime dateTime;

  Transaction({this.id, this.title, this.amount, this.dateTime});

  @override
  String toString() {
    return 'Transaction{id: $id, title: $title, amount: $amount, dateTime: $dateTime}';
  }

}
