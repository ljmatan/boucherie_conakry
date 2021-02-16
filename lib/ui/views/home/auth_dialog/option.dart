import 'package:boucherie_conakry/ui/views/user_auth/auth_page.dart';
import 'package:flutter/material.dart';

class AuthDialogOption extends StatelessWidget {
  final String label;
  final int route;

  AuthDialogOption({@required this.label, @required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => AuthPage(route)));
      },
    );
  }
}
