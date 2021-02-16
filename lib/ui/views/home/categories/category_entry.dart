import 'package:flutter/material.dart';

class CategoryEntry extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget route;

  CategoryEntry({
    @required this.icon,
    @required this.label,
    @required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: kElevationToShadow[1],
                color: Colors.white,
              ),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Center(
                  child: Icon(
                    icon,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4 - 8,
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => route),
        ),
      ),
    );
  }
}
