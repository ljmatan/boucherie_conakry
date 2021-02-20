import 'dart:async';

import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/views/specials/entry/specials_entry.dart';
import 'butchers_entry.dart';
import 'filter_dialog/filter_dialog.dart';
import 'bloc/butchers_filter_controller.dart';
import 'package:flutter/material.dart';

class ButchersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButchersPageState();
  }
}

class _ButchersPageState extends State<ButchersPage> {
  @override
  void initState() {
    super.initState();
    ButchersFilterController.init();
  }

  bool _loaded = false;
  final StreamController _loadedController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(I18N.text('meat')),
        actions: [
          StreamBuilder(
            stream: _loadedController.stream,
            initialData: false,
            builder: (context, loaded) => IconButton(
              icon: Icon(Icons.tune),
              splashColor: Colors.transparent,
              onPressed: loaded.data
                  ? () => showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) => ButchersFilterDialog(),
                      )
                  : null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ButchersFilterController.stream,
        builder: (context, filter) => FutureBuilder(
          future: WoocommerceAPI.getButchers(filter.data).whenComplete(() {
            if (!_loaded) {
              _loadedController.add(true);
              _loaded = true;
            }
          }),
          initialData: Products.butchers,
          builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> products) =>
              products.hasData && products.data.isNotEmpty
                  ? ListView.builder(
                      itemCount: products.data.length,
                      itemBuilder: (context, i) => products.data[i].description
                              .contains('Pour 4 à 8 personnes')
                          ? SpecialsEntry(
                              UniqueKey(),
                              product: products.data[i],
                              index: i,
                            )
                          : ButchersEntry(
                              UniqueKey(),
                              product: products.data[i],
                              index: i,
                            ),
                    )
                  : Center(
                      child: products.connectionState != ConnectionState.done &&
                              !products.hasData
                          ? CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                products.hasError
                                    ? products.error.toString()
                                    : 'No items found.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loadedController.close();
    ButchersFilterController.dispose();
    super.dispose();
  }
}
