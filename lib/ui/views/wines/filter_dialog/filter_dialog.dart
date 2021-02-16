import 'package:boucherie_conakry/ui/views/wines/filter_dialog/filter_option.dart';
import 'package:flutter/material.dart';

class WinesFilterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Material(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          elevation: 16,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WinesFilterOption(label: 'Rosé', categoryID: 114),
                const Divider(height: 0),
                WinesFilterOption(label: 'Champagne', categoryID: 116),
                const Divider(height: 0),
                WinesFilterOption(label: 'Vin blanc', categoryID: 113),
                const Divider(height: 0),
                WinesFilterOption(label: 'Vin rogue', categoryID: 115),
                const Divider(height: 0),
                WinesFilterOption(label: 'Annuler')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
