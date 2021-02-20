import 'dart:async';

import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'quantity_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WinesAddToCartDialog extends StatefulWidget {
  final String name;
  final int id, price, quantity;

  WinesAddToCartDialog({
    @required this.name,
    @required this.id,
    @required this.price,
    @required this.quantity,
  });

  @override
  State<StatefulWidget> createState() {
    return _WinesAddToCartDialogState();
  }
}

class _WinesAddToCartDialogState extends State<WinesAddToCartDialog> {
  int _quantity;

  final StreamController _quantityController = StreamController.broadcast();

  void _increaseQuantity() {
    _quantity++;
    _quantityController.add(_quantity);
  }

  void _decreaseQuantity() {
    if (_quantity != 1) {
      _quantity--;
      _quantityController.add(_quantity);
    }
  }

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kElevationToShadow[16],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityEditButton(
                        label: '-',
                        onTap: _decreaseQuantity,
                      ),
                      Expanded(
                        child: Center(
                          child: StreamBuilder(
                            stream: _quantityController.stream,
                            initialData: _quantity,
                            builder: (context, quantity) => Text(
                              quantity.data.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      QuantityEditButton(
                        label: '+',
                        onTap: _increaseQuantity,
                      ),
                    ],
                  ),
                ),
                if (widget.price != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(I18N.text('total') + ':'),
                        StreamBuilder(
                          stream: _quantityController.stream,
                          initialData: _quantity,
                          builder: (context, quantity) => Text(
                            '${NumberFormat().format(widget.price * quantity.data)} GNF',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 29,
                        height: 48,
                        child: Center(
                          child: Text(
                            I18N.text('cancel'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    GestureDetector(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 29,
                          height: 48,
                          child: Center(
                            child: Text(
                              I18N.text('confirm'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (widget.quantity == null)
                          CurrentOrder.addToOrder(
                            OrderItemModel(
                              name: widget.name,
                              category: 'wines',
                              id: widget.id,
                              price: widget.price,
                              quantity: _quantity,
                            ),
                          );
                        else
                          CurrentOrder.instance
                              .singleWhere((product) => product.id == widget.id)
                              .quantity = _quantity;

                        Navigator.pop(context, _quantity);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.close();
    super.dispose();
  }
}
