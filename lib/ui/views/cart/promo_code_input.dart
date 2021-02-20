import 'package:flutter/material.dart';

class PromoCodeInput extends StatelessWidget {
  final TextEditingController promoCodeController;

  PromoCodeInput(this.promoCodeController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            TextField(
              controller: promoCodeController,
              decoration: InputDecoration(
                labelText: 'Promo code',
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
