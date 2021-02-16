import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:flutter/material.dart';

class CheckoutActions extends StatelessWidget {
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
              width: MediaQuery.of(context).size.width / 2 - 16,
              height: 48,
              child: Center(
                child: Text(
                  'CLEAR ALL',
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
                width: MediaQuery.of(context).size.width / 2 - 16,
                height: 48,
                child: Center(
                  child: Text(
                    'CHECKOUT',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
