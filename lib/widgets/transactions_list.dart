import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

//Construction of visible list of transactions
class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;
  TransactionsList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //Ternary operator. List is displayed if there are transactions in it.
      //If not, suitable image with communicate is showed of.
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: AppBarTheme.of(context).titleTextStyle,
                ),
                Container(
                    height: 200,
                    margin: EdgeInsets.all(30),
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${transactions[index].amount.toStringAsFixed(2)} zł',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Column(
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(transactions[index].date),
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
