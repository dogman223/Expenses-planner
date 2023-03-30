import 'package:flutter/material.dart';
import '../model/transaction.dart';
import '../widgets/transaction_element.dart';

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
                    margin: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionElement(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
