import 'package:flutter/material.dart';

class Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Delivery within 24 hours. We will contact you when your order is ready.'
        'To be collected at our premises Corniche Sud de Coléah, Villa KWAME NKRUMAH, in front of the UTS station or delivered to your home (Conakry only - 20,000 GNF)\n\n'
        'For reasons of hygiene and safety, the products are packaged and generally delivered frozen. Possibility of fresh delivery on request on certain products.'
        'The weight of the prepared portions may vary slightly from that of the ordered portions. In the event of a substantial difference, we will inform you before delivery of the order.',
      ),
    );
  }
}
