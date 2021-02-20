import 'package:boucherie_conakry/logic/local_db/local_db.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:boucherie_conakry/ui/views/cart/cart_page.dart';
import 'package:boucherie_conakry/ui/views/home/auth_dialog/auth_dialog.dart';
import 'package:boucherie_conakry/ui/views/home/map_display.dart';
import 'package:boucherie_conakry/ui/views/profile/profile_page.dart';

import 'bloc/cart_items_number_controller.dart';
import 'call_button.dart';
import 'promotions/promotions_display.dart';
import 'about_us/about_us_display.dart';
import 'categories/categories_display.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    CartItemsNumberController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () async {
                  if (UserData.instance.id == null)
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (context) => AuthDialog(),
                    );
                  else {
                    final List<Map> orders =
                        await LocalDB.instance.rawQuery('SELECT * FROM Orders');
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ProfilePage(orders: orders)));
                  }
                },
              ),
              Image.asset(
                'assets/images/logo.png',
                height: kToolbarHeight - 10,
              ),
              StreamBuilder(
                stream: CartItemsNumberController.stream,
                initialData: CartItemsNumberController.numberOfOrders,
                builder: (context, items) => Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: items.data != 0
                          ? () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => CartPage()))
                          : null,
                    ),
                    if (items.data != 0)
                      Positioned(
                        right: 6,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                items.data.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              PromotionsDisplay(),
              CategoriesDisplay(),
              AboutUsDisplay(),
              MapDisplay(),
            ],
          ),
          CallButton(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    CartItemsNumberController.dispose();
    super.dispose();
  }
}
