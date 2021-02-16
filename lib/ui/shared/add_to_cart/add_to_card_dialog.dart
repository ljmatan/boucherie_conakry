import 'dart:async';

import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/ui/shared/add_to_cart/portion_button.dart';
import 'quantity_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddToCartDialog extends StatefulWidget {
  final String name, category;
  final int id, price, portion, quantity;

  AddToCartDialog({
    @required this.name,
    @required this.category,
    @required this.id,
    @required this.price,
    this.portion,
    @required this.quantity,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddToCartDialogState();
  }
}

class _AddToCartDialogState extends State<AddToCartDialog> {
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

  int _portion;

  final StreamController _portionController = StreamController.broadcast();

  void _setPortion(int portion) {
    _portion = portion;
    _portionController.add(_portion);
    _quantityController.add(_quantity);
  }

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity ?? 1;
    _portion = widget.portion ?? 0;
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
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PortionButton(
                        0,
                        stream: _portionController.stream,
                        setPortion: _setPortion,
                        initial: _portion,
                      ),
                      PortionButton(
                        1,
                        stream: _portionController.stream,
                        setPortion: _setPortion,
                        initial: _portion,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
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
                        Text('Total:'),
                        StreamBuilder(
                          stream: _quantityController.stream,
                          initialData: _quantity,
                          builder: (context, quantity) => Text(
                            '${NumberFormat().format(widget.price * quantity.data * (1 + _portion))} GNF',
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
                            'CANCEL',
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
                              'CONFIRM',
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
                              category: widget.category,
                              id: widget.id,
                              price: widget.price * (1 + _portion),
                              quantity: _quantity,
                              portion: _portion,
                            ),
                          );
                        else
                          CurrentOrder.instance
                              .singleWhere((product) => product.id == widget.id)
                              .quantity = _quantity;

                        Navigator.pop(context, {
                          'quantity': _quantity,
                          'portion': _portion,
                        });
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
    _portionController.close();
    super.dispose();
  }
}
