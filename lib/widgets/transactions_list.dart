import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

//Construction of visible list of transactions
class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionsList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    //Ternary operator. List is displayed if there are transactions in it.
    //If not, suitable image with communicate is showed of.
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: AppBarTheme.of(context).titleTextStyle,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    margin: EdgeInsets.all(30),
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('${transactions[index].amount}')),
                      )),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                      icon: Icon(Icons.delete)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
