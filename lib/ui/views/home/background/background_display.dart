import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/ui/views/home/background/animated_food.dart';
import 'package:flutter/material.dart';

class BackgroundDisplay extends StatelessWidget {
  final PageController pageController;

  BackgroundDisplay(this.pageController);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          kToolbarHeight -
          MediaQuery.of(context).padding.top,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          AnimatedFood(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  I18N.text('meat') + '\n' + I18N.text('seafood'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffFFE8BC),
                    fontSize: 46,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 20),
                  child: Text(
                    I18N.text('adabout'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xff82B440),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Text(
                        I18N.text('order'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.ease,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
