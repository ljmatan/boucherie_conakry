import 'package:flutter/material.dart';

class PromoCodeInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PromoCodeInputState();
  }
}

class _PromoCodeInputState extends State<PromoCodeInput> {
  final _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            TextField(
              controller: _promoCodeController,
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
