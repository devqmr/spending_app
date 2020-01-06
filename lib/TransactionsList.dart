import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/Transaction.dart';

class TransactionsList extends StatelessWidget {
  List<Transaction> transactionsList;
  Function deleteTransaction;

  TransactionsList(this.transactionsList, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    if (transactionsList.isNotEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 6,
              ),
              child: ListTile(
                title: Text(transactionsList[index].title),
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                        child: Text("\$${transactionsList[index].amount}")),
                  ),
                ),
                subtitle: Text(DateFormat.yMMMEd()
                    .format(transactionsList[index].dateTime)),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    deleteTransaction(index);
                  },
                ),
              ));
        },
        itemCount: transactionsList.length,
      );
    } else {
      return Image.asset('assets/images/mirage-list-is-empty.png');
    }
  }
}
