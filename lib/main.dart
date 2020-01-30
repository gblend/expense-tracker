import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueGrey,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: 'Gupter',
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'Gupter', fontSize: 28.0),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 50.9,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 100.0,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    final newTX = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString(),
        );

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).accentColor,
            padding: const EdgeInsets.all(2.0),
            icon: Icon(Icons.add_circle_outline),
            iconSize: 25.0,
            hoverColor: Colors.lightBlueAccent,
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
        centerTitle: true,
        title: Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _userTransactions.isEmpty
                ? SizedBox(height: 100.0)
                : Container(
                    // padding: EdgeInsets.only(bottom: 10.0),
                    width: double.infinity,
                    height: 180.0,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Chart(_recentTransactions),
                      ),
                      elevation: 5.0,
                    ),
                  ),
                  SizedBox(height: 20.0,),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add expense',
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
