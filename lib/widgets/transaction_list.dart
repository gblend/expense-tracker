import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Expenses Added Yet',
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 250.0,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         padding: EdgeInsets.all(3.0),
                //         margin: EdgeInsets.symmetric(
                //             vertical: 10.0, horizontal: 15.0),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Colors.black,
                //             width: 1.0,
                //           ),
                //           borderRadius: BorderRadius.circular(10.0),
                //         ),
                //         child: Text(
                //           // naira symbol
                //           '\u{20A6}${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20,
                //               color: Theme.of(context).primaryColorDark),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[index].title,
                //             style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16.0,
                //             ),
                //           ),
                //           Text(
                //             DateFormat('yyyy-MM-dd')
                //                 .format(transactions[index].date),
                //             style: TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                            child: Text(
                          '\u{20A6}${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              fontSize: 30.0),
                        )),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.title),
                    subtitle:
                        Text(DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      iconSize: 20.0,
                      padding: EdgeInsets.all(5.0),
                      color: Colors.redAccent,
                      onPressed: () => deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
