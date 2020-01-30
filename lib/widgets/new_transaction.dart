import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() =>
      _NewTransactionState(this.addTransaction);
}

class _NewTransactionState extends State<NewTransaction> {
  final Function addTransaction;
  _NewTransactionState(this.addTransaction);

  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  final dateSelected = TextEditingController();
  DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();

  void _saveExpense() {
    if (_selectedDate == null) {
      return;
    }
    setState(() {
      if (_formKey.currentState.validate()) {
        addTransaction(titleInput.text, double.parse(amountInput.text), _selectedDate);

        titleInput.clear();
        amountInput.clear();
        Navigator.of(context).pop();
      }
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0),
                //     child: Center(
                //       child: Text(
                //         'Record Expense',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w300,
                //           fontSize: 20,
                //           letterSpacing: 1.4,
                //           color: Colors.black,
                //         ),
                //       ),
                //     )
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.title,
                  labelText: 'Expense Title',
                  hintText: 'Enter expense title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                controller: titleInput,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title is required';
                  }
                },
                // onFieldSubmitted: (_) => saveExpense(),
              ),
              Container(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.title,
                  labelText: 'Expense Amount',
                  hintText: 'Enter amount spent',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                controller: amountInput,
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Amount spent is required';
                  }
                },
                onFieldSubmitted: (_) => _saveExpense(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _selectedDate == null
                        ? Text(
                            'No date selected',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          )
                        : Text(
                            'Selected Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Add Expense'),
                textColor: Colors.white,
                onPressed: () => _saveExpense(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
