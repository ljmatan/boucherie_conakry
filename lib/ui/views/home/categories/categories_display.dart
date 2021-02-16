import 'package:boucherie_conakry/other/food_icons.dart';
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
                'Catégories',
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
                icon: FoodIcons.chicken_leg,
                label: 'Boucherie',
                route: ButchersPage(),
              ),
              CategoryEntry(
                icon: FoodIcons.fish,
                label: 'Poissonnerie',
                route: SeafoodPage(),
              ),
              CategoryEntry(
                icon: FoodIcons.glass_cheers,
                label: 'Vins',
                route: WinesPage(),
              ),
              CategoryEntry(
                icon: FoodIcons.knife_fork,
                label: 'Spécialités',
                route: SpecialsPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
