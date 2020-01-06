import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spending_app/NewTransaction.dart';
import 'package:spending_app/model/Transaction.dart';

import 'TransactionsList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: MyHomePage(title: 'Spending App (Demo)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

//  List<Transaction> transactionsList = new List<Transaction>();

  List<Transaction> transactionsList = [new Transaction(title: "AAA",
      amount: 99.9,
      dateTime: DateTime.now(),
      id: DateTime.now().toString()),
    new Transaction(title: "BBB",
        amount: 888.8,
        dateTime: DateTime.now(),
        id: DateTime.now().toString()),
    new Transaction(title: "CCC",
        amount: 77.7,
        dateTime: DateTime.now(),
        id: DateTime.now().toString())
  ];


  void _showAddTransaction(context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction((Transaction transaction) {
              setState(() {
                showToast("Add Transaction From Main > \n $transaction");
                transactionsList.add(transaction);
              });
            }),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void showToast(String msgToast) {
    Fluttertoast.showToast(
        msg: msgToast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TransactionsList(transactionsList, deleteTransaction),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTransaction(context);
        },
//        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }


  void deleteTransaction(int index) {
    setState(() {
      showToast("$index");
      transactionsList.removeAt(index);
    });
  }
}
