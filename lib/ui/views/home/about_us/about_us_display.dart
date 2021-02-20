import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:flutter/material.dart';

class AboutUsDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'GUI Food',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(I18N.text('about')),
          ),
        ],
      ),
    );
  }
}
