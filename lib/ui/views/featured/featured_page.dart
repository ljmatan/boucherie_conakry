import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/ui/views/butchers/butchers_entry.dart';
import 'package:boucherie_conakry/ui/views/seafood/entry/seafood_entry.dart';
import 'package:boucherie_conakry/ui/views/specials/entry/specials_entry.dart';
import 'package:boucherie_conakry/ui/views/wines/wine_entry.dart';
import 'package:flutter/material.dart';

class FeaturedPage extends StatelessWidget {
  static Future<List<Product>> _getFeatured = WoocommerceAPI.getFeatured();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text('Promotions'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getFeatured,
        initialData: Products.seafood,
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
                        : products.data[i].categories.first.id == 113 ||
                                products.data[i].categories.first.id == 114 ||
                                products.data[i].categories.first.id == 115 ||
                                products.data[i].categories.first.id == 116
                            ? WineEntry(
                                UniqueKey(),
                                product: products.data[i],
                                index: i,
                              )
                            : products.data[i].categories.first.id == 82
                                ? SeafoodEntry(
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
    );
  }
}
