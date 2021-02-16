import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/ui/views/seafood/entry/seafood_entry.dart';
import 'package:flutter/material.dart';

class SeafoodPage extends StatelessWidget {
  static Future<List<Product>> _getSeafood = WoocommerceAPI.getSeafood();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text('Poissonnerie'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getSeafood,
        initialData: Products.seafood,
        builder: (BuildContext context,
                AsyncSnapshot<List<Product>> products) =>
            products.hasData && products.data.isNotEmpty
                ? ListView.builder(
                    itemCount: products.data.length,
                    itemBuilder: (context, i) => SeafoodEntry(
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
    );
  }
}
