import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './model/transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    //Transaction(id: 'T1', title: "Test1", amount: 99.99, date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  //Start new transaction function that shows sheet that allows to add new transaction
  void _startAddNewTransaction(BuildContext cxt) {
    showModalBottomSheet(
        context: cxt,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          //Using of my choosed primary color
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionsList(_transactions, _deleteTransaction)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)));
  }
}
