import 'dart:async';

import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'bloc/wines_filter_controller.dart';
import 'wine_entry.dart';
import 'filter_dialog/filter_dialog.dart';
import 'package:flutter/material.dart';

class WinesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WinesPageState();
  }
}

class _WinesPageState extends State<WinesPage> {
  @override
  void initState() {
    super.initState();
    WinesFilterController.init();
  }

  bool _loaded = false;
  final StreamController _loadedController = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text('Vins'),
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
                        builder: (context) => WinesFilterDialog(),
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
        stream: WinesFilterController.stream,
        builder: (context, filter) => FutureBuilder(
          future: WoocommerceAPI.getWines(filter.data).whenComplete(() {
            if (!_loaded) {
              _loadedController.add(true);
              _loaded = true;
            }
          }),
          initialData: Products.wines,
          builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> products) =>
              products.hasData && products.data.isNotEmpty
                  ? ListView.builder(
                      itemCount: products.data.length,
                      itemBuilder: (context, i) => WineEntry(
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
    WinesFilterController.dispose();
    super.dispose();
  }
}
