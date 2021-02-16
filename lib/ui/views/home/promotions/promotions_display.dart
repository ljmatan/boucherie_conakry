import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'promotions_carousel/promotions_carousel_display.dart';
import 'package:flutter/material.dart';

class PromotionsDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PromotionsDisplayState();
  }
}

class _PromotionsDisplayState extends State<PromotionsDisplay> {
  bool _viewAllButtonDisplayed = false;

  void _showViewAllButton() => setState(() => _viewAllButtonDisplayed = true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promotions',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    _viewAllButtonDisplayed ? I18N.text('view all') : '',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: _viewAllButtonDisplayed ? () {} : null,
              ),
            ],
          ),
        ),
        PromotionsCarousel(_showViewAllButton),
      ],
    );
  }
}
