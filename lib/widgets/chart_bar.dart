import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('${spendingAmount.toStringAsFixed(0)} zł'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        //Bar:
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      //Promień obramowania dla zaokrąglonych rogów
                      borderRadius: BorderRadius.circular(10))),
              FractionallySizedBox(
                heightFactor: spendingPercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      //Druga granica obramowania o takich samych wymiarach,
                      //aby oba kontenery pasowały do siebie w odniesieniu do granic i krawędzi:
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
