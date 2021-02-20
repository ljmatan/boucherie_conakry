import 'package:boucherie_conakry/logic/i18n/i18n.dart';
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Material(
          elevation: 16,
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthDialogOption(label: I18N.text('register'), route: 0),
                AuthDialogOption(label: I18N.text('login'), route: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
