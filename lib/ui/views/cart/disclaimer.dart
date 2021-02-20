import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(I18N.text('disclaimer')),
    );
  }
}
