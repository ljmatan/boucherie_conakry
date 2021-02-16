import 'package:boucherie_conakry/ui/views/home/auth_dialog/option.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthDialogState();
  }
}

class _AuthDialogState extends State<AuthDialog> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Colors.white70,
                  Colors.white.withAlpha(0)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 300, 12, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuthDialogOption(label: 'REGISTER', route: 0),
                  AuthDialogOption(label: 'LOGIN', route: 1),
                ],
              ),
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
