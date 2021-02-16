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
            child: Text(
              'La Boucherie – Poissonnerie GUI FOOD, à Conakry, propose des produits de qualité pour faire de chacun de vos repas une véritable réussite.\n\n'
              'Les commandes sont disponibles sous 24h, à collecter à la Boucherie, Corniche Sud de Coléah, Villa KWAME NKRUMAH , '
              'en face de la station UTS ou livrées à domicile (Conakry uniquement – 20 000 GNF)',
            ),
          ),
        ],
      ),
    );
  }
}
