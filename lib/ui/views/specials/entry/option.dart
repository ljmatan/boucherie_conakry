import 'package:flutter/material.dart';

class SpecialsOrderOption extends StatelessWidget {
  final int amount;
  final IconData icon;
  final String label;

  SpecialsOrderOption({
    @required this.amount,
    @required this.icon,
    @required this.label,
  });

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
              if (amount == null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(icon, size: 16),
                ),
              Text(
                (amount == null
                        ? ''
                        : '${amount + (label == 'Personnes' ? 1 : 0)} ') +
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
