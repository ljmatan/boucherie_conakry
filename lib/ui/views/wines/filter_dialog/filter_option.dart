import 'package:boucherie_conakry/ui/views/wines/bloc/wines_filter_controller.dart';
import 'package:flutter/material.dart';

class WinesFilterOption extends StatelessWidget {
  final String label;
  final int categoryID;

  WinesFilterOption({@required this.label, this.categoryID});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 54,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: WinesFilterController.currentlySelected == categoryID &&
                      categoryID != null
                  ? Theme.of(context).accentColor
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      onTap: () {
        WinesFilterController.change(
          WinesFilterController.currentlySelected == categoryID
              ? null
              : categoryID,
        );
        Navigator.pop(context);
      },
    );
  }
}
