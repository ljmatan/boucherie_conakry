import 'filter_option.dart';
import 'package:flutter/material.dart';

class ButchersFilterDialog extends StatelessWidget {
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
                ButchersFilterOption(label: 'Mouton', categoryID: 15),
                const Divider(height: 0),
                ButchersFilterOption(label: 'bœuf', categoryID: 72),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Burger Bomb', categoryID: 100),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Porc', categoryID: 62),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Poulet du pays', categoryID: 111),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Saucisse', categoryID: 84),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Veau', categoryID: 93),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Volaille', categoryID: 96),
                const Divider(height: 0),
                ButchersFilterOption(label: 'Annuler')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
