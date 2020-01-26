import 'package:meta/meta.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required @required this.amount,
      @required this.date}
      );
}
