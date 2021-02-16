import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/ui/views/cart/checkout_actions.dart';
import 'package:boucherie_conakry/ui/views/cart/payment_method.dart';
import 'package:boucherie_conakry/ui/views/cart/products.dart';
import 'package:boucherie_conakry/ui/views/cart/promo_code_input.dart';
import 'package:boucherie_conakry/ui/views/cart/shipping_details.dart';
import 'package:boucherie_conakry/ui/views/cart/total_cost.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  Set<String> _categories = {};

  void _setCategories() {
    if (_categories.isNotEmpty) _categories.clear();
    for (var product in CurrentOrder.instance)
      _categories.add(product.category);
  }

  @override
  void initState() {
    super.initState();
    _setCategories();
  }

  void _updateCart() => setState(() => _setCategories());

  int get _totalCost {
    int cost = 0;
    for (var product in CurrentOrder.instance)
      cost += product.price * product.quantity;
    return cost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        children: [
          CartProducts(categories: _categories, refresh: _updateCart),
          PromoCodeInput(),
          TotalCost(totalCost: _totalCost),
          ShippingDetails(),
          PaymentMethodSelection(),
          CheckoutActions(),
        ],
      ),
    );
  }
}
