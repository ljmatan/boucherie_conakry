import 'package:flutter/material.dart';

class SpecialsOrderOption extends StatelessWidget {
  final IconData icon;
  final String label;

  SpecialsOrderOption({@required this.icon, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(icon, size: 16),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
