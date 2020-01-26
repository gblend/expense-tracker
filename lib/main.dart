import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 50.9,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 100.0,
      date: DateTime.now(),
    )
  ];

  final titleInput = TextEditingController();

  final amountInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            hoverColor: Colors.lightBlueAccent,
            icon: Icon(Icons.menu),
            iconSize: 40.0,
            color: Colors.black,
            onPressed: () => print('Menu pressed'),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.all(2.0),
              icon: Icon(Icons.note_add),
              iconSize: 25.0,
              hoverColor: Colors.lightBlueAccent,
              onPressed: () => print('Setting pressed'),
            )
          ],
          centerTitle: true,
          title: Text('Expense Tracker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 120.0,
              child: Card(
                color: Colors.blue[50],
                child: Text('Chart'),
                elevation: 5.0,
              ),
            ),
            Form(
              key: _formKey,
              child: Card(
                elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter title',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                      ),
                      controller: titleInput,
                      validator: (value) {
                        if(value.isEmpty){
                          return 'Title is required';
                        }
                      }
                    ),
                    Container(height: 5.0),
                    TextFormField(
                    
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      controller: amountInput,
                      validator: (val) {
                        if(val.isEmpty){
                          return 'Amount is required';
                        }
                      }
                    ),
                    FlatButton(
                      child: Text('Add Transaction'),
                      textColor: Colors.blueAccent,
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState.validate()){
                          print('Saved');
                        }
                        });
                      },
                    ),
                ],
              ),
                  )),
            ),
            Column(
              children: transactions.map((tx) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(3.0),
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          // naira symbol
                          '\u{20A6}${tx.amount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
