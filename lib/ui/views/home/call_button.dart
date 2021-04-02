import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  static const String _phoneNumber = '+224 626 01 11 00';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: GestureDetector(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            boxShadow: kElevationToShadow[2],
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: 64,
            height: 64,
            child: Center(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14),
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        onTap: () async {
          if (await canLaunch('tel:' + _phoneNumber))
            launch('tel:' + _phoneNumber);
          else
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_phoneNumber),
                duration: const Duration(seconds: 6),
              ),
            );
        },
      ),
    );
  }
}
