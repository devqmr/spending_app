import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:spending_app/model/Transaction.dart';

class NewTransaction extends StatefulWidget {
  Function _addTransaction;

  @override
  _NewTrState createState() => _NewTrState();

  NewTransaction(this._addTransaction);
}

class _NewTrState extends State<NewTransaction> {
  DateTime _dateTime = null;
  String _dateTimeLabel = "Pick Date:";
  String _titleText;
  String _amountText;

  void showToast(String msgToast) {
    Fluttertoast.showToast(
        msg: msgToast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void createTransaction() {
    double amount = 0.0;

    _titleText = titleTextEditingController.text;
    _amountText = amountTextEditingController.text;

    if (_titleText == null || _titleText.isEmpty) {
      showToast("Enter the title");
      return;
    }

    if (_amountText == null || _amountText.isEmpty) {
      showToast("Enter the amount");
      return;
    }

    try {
      amount = double.parse(_amountText);
    } catch (e) {
      print(e);
      showToast("Enter valid amount");
      return;
    }

    if (_dateTime == null) {
      showToast("Pick Date");
      return;
    }

    Transaction transaction = new Transaction(
        id: DateTime.now().toString(),
        title: _titleText,
        amount: amount,
        dateTime: _dateTime);

    widget._addTransaction(transaction);

    Navigator.pop(context);
  }

  var titleTextEditingController = TextEditingController();
  var amountTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: "Title", contentPadding: EdgeInsets.all(8)),
                controller: titleTextEditingController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Amount", contentPadding: EdgeInsets.all(8)),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                controller: amountTextEditingController,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_dateTimeLabel),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Choose Date"),
                      onPressed: () {
                        Future<DateTime> selectDate = showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2018),
                          lastDate: DateTime.now(),
                        );

                        selectDate.then((DateTime date) {
                          setState(() {
                            String msgToast = "";
                            if (date == null) {
                              msgToast = "Date not selected";
                            } else {
                              _dateTime = date;
                              msgToast = "Date > $date";
                            }

                            _dateTimeLabel =
                                "Pick Date: ${new DateFormat.yMMMMd().format(_dateTime)}";
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Add Transaction"),
                      onPressed: createTransaction,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
