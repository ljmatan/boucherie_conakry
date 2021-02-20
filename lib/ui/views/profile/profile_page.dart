import 'dart:convert';

import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:boucherie_conakry/ui/views/profile/address_input.dart';
import 'package:boucherie_conakry/ui/views/profile/reset_password_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final List<Map> orders;

  ProfilePage({@required this.orders});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map> _ordersDecoded = [];

  @override
  void initState() {
    super.initState();
    for (var order in widget.orders)
      _ordersDecoded.add(jsonDecode(order['orderJsonEncoded']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(
          '${UserData.instance.firstName} ${UserData.instance.lastName}',
        ),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: ResetPasswordButton(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 7),
            child: Text(
              I18N.text('address'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AddressInput(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
            child: Text(
              I18N.text('previous orders'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          _ordersDecoded.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(height: 0),
                    for (var order in _ordersDecoded)
                      ExpansionTile(
                        title: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${order['dateTime'].substring(0, 10)} - ',
                              ),
                              TextSpan(
                                text:
                                    '${NumberFormat().format(order['totalCost'])} GNF',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        children: [
                          for (var product in order['products'])
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: Text(
                                      '${product['quantity']}X',
                                      style: const TextStyle(fontSize: 28),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        product['name'] +
                                            (product['portion'] == null
                                                ? ''
                                                : product['portion'] == 0
                                                    ? ' 500g'
                                                    : ' 1kg'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        I18N.text('sum') +
                                            ': ${NumberFormat().format(product['price'] * product['quantity'])} GNF',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(I18N.text('no previous orders recorded')),
                ),
        ],
      ),
    );
  }
}
