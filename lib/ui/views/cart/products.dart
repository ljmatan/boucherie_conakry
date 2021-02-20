import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
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
              I18N.text(category),
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
                                product.name +
                                    (product.portion == null
                                        ? ''
                                        : product.portion == 0
                                            ? ' 500g'
                                            : ' 1kg'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                I18N.text('sum') +
                                    ': ${NumberFormat().format(product.price * product.quantity)} GNF',
                              ),
                            ],
                          ),
                        ],
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: const Text(' - '),
                              onTap: () {
                                if (product.quantity > 1) {
                                  CurrentOrder.instance
                                      .singleWhere((addedProduct) =>
                                          product.id == addedProduct.id)
                                      .quantity = product.quantity - 1;
                                  refresh();
                                } else {
                                  CurrentOrder.removeFromOrder(product.id);
                                  if (CurrentOrder.instance.length == 0)
                                    Navigator.pop(context);
                                  else
                                    refresh();
                                }
                              },
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: const Text(' + '),
                              onTap: () {
                                CurrentOrder.instance
                                    .singleWhere((addedProduct) =>
                                        product.id == addedProduct.id)
                                    .quantity = product.quantity + 1;
                                refresh();
                              },
                            ),
                          ],
                        ),
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
