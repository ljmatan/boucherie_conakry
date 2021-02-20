import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/other/custom_icons.dart';
import 'package:boucherie_conakry/ui/views/butchers/butchers_page.dart';
import 'package:boucherie_conakry/ui/views/home/categories/category_entry.dart';
import 'package:boucherie_conakry/ui/views/seafood/seafood_page.dart';
import 'package:boucherie_conakry/ui/views/specials/specials_page.dart';
import 'package:boucherie_conakry/ui/views/wines/wines_page.dart';
import 'package:flutter/material.dart';

class CategoriesDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                I18N.text('categories'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryEntry(
                icon: CustomIcons.chicken_leg,
                label: I18N.text('meat'),
                route: ButchersPage(),
              ),
              CategoryEntry(
                icon: CustomIcons.fish,
                label: I18N.text('seafood'),
                route: SeafoodPage(),
              ),
              CategoryEntry(
                icon: CustomIcons.glass_cheers,
                label: I18N.text('wines'),
                route: WinesPage(),
              ),
              CategoryEntry(
                icon: CustomIcons.knife_fork,
                label: I18N.text('specials'),
                route: SpecialsPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
