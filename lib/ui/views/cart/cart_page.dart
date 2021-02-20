import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:boucherie_conakry/ui/views/cart/auth_actions.dart';
import 'package:boucherie_conakry/ui/views/cart/checkout_actions.dart';
import 'package:boucherie_conakry/ui/views/cart/disclaimer.dart';
import 'package:boucherie_conakry/ui/views/cart/payment_method.dart';
import 'package:boucherie_conakry/ui/views/cart/products.dart';
import 'package:boucherie_conakry/ui/views/cart/promo_code_input.dart';
import 'package:boucherie_conakry/ui/views/cart/shipping_details.dart';
import 'package:boucherie_conakry/ui/views/cart/total_cost.dart';
import 'package:flutter/material.dart';

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

  final _promoCodeController = TextEditingController();
  final _firstNameController =
      TextEditingController(text: UserData.instance.firstName ?? '');
  final _lastNameController =
      TextEditingController(text: UserData.instance.lastName ?? '');
  final _phoneNumberController =
      TextEditingController(text: UserData.instance.number ?? '');
  final _addressController =
      TextEditingController(text: UserData.instance.address ?? '');
  final _noteController = TextEditingController();

  void _rebuildCart() => setState(() {
        _firstNameController.text = UserData.instance.firstName;
        _lastNameController.text = UserData.instance.lastName;
        _phoneNumberController.text = UserData.instance.number ?? '';
        _addressController.text = UserData.instance.address ?? '';
      });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: Text(I18N.text('cart')),
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
            PromoCodeInput(_promoCodeController),
            TotalCost(totalCost: _totalCost),
            if (UserData.instance.id == null)
              AuthActions(rebuildCart: _rebuildCart),
            ShippingDetails(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              numberController: _phoneNumberController,
              addressController: _addressController,
              noteController: _noteController,
            ),
            PaymentMethodSelection(),
            Disclaimer(),
            CheckoutActions(
              totalCost: _totalCost,
              promoCodeController: _promoCodeController,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              numberController: _phoneNumberController,
              addressController: _addressController,
              noteController: _noteController,
            ),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  @override
  void dispose() {
    _promoCodeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
