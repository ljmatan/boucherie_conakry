import 'package:boucherie_conakry/ui/views/home/auth_dialog/auth_dialog.dart';
import 'package:boucherie_conakry/ui/views/home/map_display.dart';

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
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (context) => AuthDialog(),
                ),
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
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {},
                    ),
                    if (items.data != 0)
                      Positioned(
                        right: 6,
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
