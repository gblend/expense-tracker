import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            height: 20.0,
            child: FittedBox(
                child: Text('\u{20A6}${spendingAmount.toStringAsFixed(0)}')),
          ),
          SizedBox(height: 4.0),
          Container(
            height: 70.0,
            width: 10.0,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(label),
        ],
      ),
    );
  }
}
