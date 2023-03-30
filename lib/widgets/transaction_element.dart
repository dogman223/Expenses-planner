import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionElement extends StatelessWidget {
  const TransactionElement({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                    child: Text('${transaction.amount.toStringAsFixed(2)}')))),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMd().format(transaction.date),
        ),
        trailing: IconButton(
            onPressed: () => deleteTransaction(transaction.id),
            icon: const Icon(Icons.delete)),
      ),
    );
  }
}
