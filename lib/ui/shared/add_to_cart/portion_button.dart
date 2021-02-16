import 'package:flutter/material.dart';

class PortionButton extends StatelessWidget {
  final int portionNumber, initial;
  final Stream stream;
  final Function setPortion;

  PortionButton(
    this.portionNumber, {
    @required this.stream,
    @required this.setPortion,
    @required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: initial,
      builder: (context, selectedPortion) => GestureDetector(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: portionNumber == selectedPortion.data
                  ? Theme.of(context).accentColor
                  : Colors.grey,
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 32,
            height: 48,
            child: Center(
              child: Text(
                portionNumber == 0 ? '500g' : '1kg',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: portionNumber == selectedPortion.data
                      ? FontWeight.bold
                      : null,
                  color: portionNumber == selectedPortion.data
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          if (selectedPortion.data != portionNumber) setPortion(portionNumber);
        },
      ),
    );
  }
}
