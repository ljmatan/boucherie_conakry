import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCost extends StatelessWidget {
  final int totalCost;

  TotalCost({@required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            I18N.text('total') + ':',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Text(
            '${NumberFormat().format(totalCost)} GNF',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
