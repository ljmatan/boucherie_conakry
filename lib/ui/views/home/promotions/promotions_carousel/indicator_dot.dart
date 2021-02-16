import 'bloc/promotion_index_controller.dart';
import 'package:flutter/material.dart';

class IndicatorDot extends StatelessWidget {
  final int index;

  IndicatorDot({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: StreamBuilder(
          stream: PromotionIndexController.stream,
          initialData: 0,
          builder: (context, currentPage) => DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage.data == index
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              border: Border.all(color: Theme.of(context).accentColor),
            ),
            child: const SizedBox(width: 10, height: 10),
          ),
        ),
      ),
    );
  }
}
