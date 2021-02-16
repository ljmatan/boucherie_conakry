import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapDisplay extends StatelessWidget {
  static const String _locationURL =
      'https:www.google.com/maps/search/?api=1&query=9.533645,-13.67333';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[1],
        ),
        child: GestureDetector(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Image.asset(
                  'assets/images/mapbox_logo.png',
                  height: 16,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Icon(Icons.navigation),
              ),
            ],
          ),
          onTap: () async {
            if (await canLaunch(_locationURL)) launch(_locationURL);
          },
        ),
      ),
    );
  }
}
