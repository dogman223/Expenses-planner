import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Manager of new transaction input
class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  //Execution of entering values
  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    //Adding transaction is cancelled if there is no input vaules
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    //Included function that adding two controllers for an editable text field
    widget.addTransactionHandler(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  //Choosing date of transaction functionality
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
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
    return Card(
      //Add new transaction functionality which is showed on the modalBottomSheet:
      child: Column(
        children: <Widget>[
          //Title of transaction input:
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          //Amount of transaction input:
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
          ),
          //Choosing date of transaction functionality:
          Row(
            children: <Widget>[
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}'),
              ),
              TextButton(
                  onPressed: _presentDatePicker, child: Text("Choose date"))
            ],
          ),
          //Add transaction submit button:
          ElevatedButton(
            child: Text('Add Transaction'),
            onPressed: _submitData,
          )
        ],
      ),
    );
  }
}
