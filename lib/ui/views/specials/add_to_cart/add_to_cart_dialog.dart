import 'dart:async';

import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/shared/add_to_cart/quantity_edit_button.dart';
import 'package:boucherie_conakry/ui/views/specials/add_to_cart/people_option.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpecialsAddToCart extends StatefulWidget {
  final Product product;
  final int quantity, persons;

  SpecialsAddToCart({
    @required this.product,
    @required this.quantity,
    @required this.persons,
  });

  @override
  State<StatefulWidget> createState() {
    return _SpecialsAddToCartState();
  }
}

class _SpecialsAddToCartState extends State<SpecialsAddToCart> {
  int _quantity, _persons;

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

  final StreamController _personsController = StreamController.broadcast();

  void _setPersons(int persons) {
    _persons = persons;
    _personsController.add(_persons);
    _quantityController.add(_quantity);
  }

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity ?? 1;
    _persons = widget.persons ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Material(
          elevation: 16,
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('Persons'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < 5; i++)
                          PeopleOption(
                            index: i,
                            initial: _persons,
                            stream: _personsController.stream,
                            setPersons: _setPersons,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 5; i < 10; i++)
                          PeopleOption(
                            index: i,
                            initial: _persons,
                            stream: _personsController.stream,
                            setPersons: _setPersons,
                          ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Row(
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
                          '${NumberFormat().format(int.tryParse(widget.product.price) * quantity.data * (1 + _persons))} GNF',
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
                              name: widget.product.name,
                              category: 'specials',
                              id: widget.product.id,
                              price: int.tryParse(widget.product.price) *
                                  (1 + _persons),
                              quantity: _quantity,
                              variationID: widget.product.variations[_persons],
                            ),
                          );
                        else
                          CurrentOrder.instance
                              .singleWhere(
                                  (product) => product.id == widget.product.id)
                              .quantity = _quantity;

                        Navigator.pop(context, {
                          'quantity': _quantity,
                          'persons': _persons,
                        });
                      },
                    ),
                  ],
                )
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
    _personsController.close();
    super.dispose();
  }
}
