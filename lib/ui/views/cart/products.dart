import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartProducts extends StatelessWidget {
  final Set<String> categories;
  final Function refresh;

  CartProducts({@required this.categories, @required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var category in categories)
          ExpansionTile(
            title: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            initiallyExpanded: true,
            children: [
              for (var product in CurrentOrder.instance
                  .where((product) => product.category == category))
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              '${product.quantity}X',
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sum: ${NumberFormat().format(product.price * product.quantity)} GNF',
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).accentColor,
                        ),
                        onTap: () {
                          CurrentOrder.removeFromOrder(product.id);
                          if (CurrentOrder.instance.length == 0)
                            Navigator.pop(context);
                          else
                            refresh();
                        },
                      ),
                    ],
                  ),
                ),
            ],
          )
      ],
    );
  }
}
