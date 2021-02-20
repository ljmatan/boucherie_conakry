import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'entry/specials_entry.dart';
import 'package:flutter/material.dart';

class SpecialsPage extends StatelessWidget {
  static Future<List<Product>> _getSpecialties =
      WoocommerceAPI.getSpecialties();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(I18N.text('specials')),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getSpecialties,
        initialData: Products.specialties,
        builder: (BuildContext context,
                AsyncSnapshot<List<Product>> products) =>
            products.hasData && products.data.isNotEmpty
                ? ListView.builder(
                    itemCount: products.data.length,
                    itemBuilder: (context, i) => SpecialsEntry(
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
