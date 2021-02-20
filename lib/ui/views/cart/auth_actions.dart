import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/views/user_auth/auth_page.dart';
import 'package:flutter/material.dart';

class AuthActions extends StatelessWidget {
  final Function rebuildCart;

  AuthActions({@required this.rebuildCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                  I18N.text('register'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            onTap: () async {
              final rebuild = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => AuthPage(0)));
              if (rebuild) rebuildCart();
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
                    I18N.text('login'),
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
              final rebuild = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => AuthPage(1)));
              if (rebuild) rebuildCart();
            },
          ),
        ],
      ),
    );
  }
}
