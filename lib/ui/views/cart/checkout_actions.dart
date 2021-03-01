import 'dart:convert';

import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/logic/api/firebase/firebase.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/local_db/local_db.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:boucherie_conakry/ui/views/cart/purchase_success_dialog.dart';
import 'package:flutter/material.dart';

class CheckoutActions extends StatelessWidget {
  final int totalCost;
  final TextEditingController promoCodeController,
      firstNameController,
      lastNameController,
      numberController,
      addressController,
      noteController;

  CheckoutActions({
    @required this.totalCost,
    @required this.promoCodeController,
    @required this.firstNameController,
    @required this.lastNameController,
    @required this.numberController,
    @required this.addressController,
    @required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 21,
              height: 48,
              child: Center(
                child: Text(
                  I18N.text('clear all'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            onTap: () {
              CurrentOrder.clearAll();
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).accentColor,
                boxShadow: kElevationToShadow[2],
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 21,
                height: 48,
                child: Center(
                  child: Text(
                    I18N.text('checkout'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () async {
              if (firstNameController.text.isNotEmpty &&
                  lastNameController.text.isNotEmpty &&
                  RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                      .hasMatch(numberController.text)) {
                FocusScope.of(context).unfocus();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: Colors.transparent,
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()));

                await Prefs.instance
                    .setString('phoneNumber', numberController.text);
                if (addressController.text.isNotEmpty)
                  await Prefs.instance
                      .setString('address', addressController.text);
                try {
                  final response = await WoocommerceAPI.newOrder(
                    firstNameController.text,
                    lastNameController.text,
                    numberController.text,
                    addressController.text,
                    promoCodeController.text,
                    noteController.text,
                  );
                  if (response.statusCode == 201) {
                    final thisOrder = {
                      'orderJsonEncoded': jsonEncode(
                        {
                          'dateTime': DateTime.now().toIso8601String(),
                          'totalCost': totalCost,
                          'products': [
                            for (var product in CurrentOrder.instance)
                              {
                                'name': product.name,
                                'category': product.category,
                                'quantity': product.quantity,
                                'portion': product.portion,
                                'price': product.price,
                              }
                          ],
                        },
                      ),
                    };
                    await LocalDB.instance.insert('orders', thisOrder);
                    if (UserData.instance.id != null)
                      try {
                        FirebaseAPI.updateOrders(thisOrder);
                      } catch (e) {
                        print(e.toString());
                      }
                    Navigator.pop(context);
                    CurrentOrder.clearAll();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.transparent,
                      builder: (context) => PurchaseSuccessDialog(),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(jsonDecode(response.body)['message'])));
                    Navigator.pop(context);
                  }
                } catch (e) {
                  Navigator.pop(context);
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('$e')));
                }
              } else
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(I18N.text('name or number missing'))));
            },
          ),
        ],
      ),
    );
  }
}
