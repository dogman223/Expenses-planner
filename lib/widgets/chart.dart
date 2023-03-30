import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
  //Tworzę listę zawierającą mapę, czyli listę z elementami wartość-klucz:
  List<Map<String, Object>> get groupedTransactionValues {
    //Zwracana lista zawiera 7 elementów, indeksów:
    return List.generate(7, (index) {
      //Zmienna przechowująca różnicę: dzień dzisiejszy - indeks;
      //otrzymujemy ostatnie siedem dni licząc od dziś:
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekday));
      print(totalSum);
      //Zwrot sumy wartości transakcji z danego dnia tygodnia
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending);
          }).toList(),
        ),
      ),
    );
  }
}
