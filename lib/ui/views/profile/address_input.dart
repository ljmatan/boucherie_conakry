import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:flutter/material.dart';

class AddressInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressInputState();
  }
}

class _AddressInputState extends State<AddressInput> {
  final _addressController = TextEditingController();

  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: _addressController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(16, 16, 42, 16),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(
              Icons.check,
              color: _saved ? Colors.green : Colors.black,
            ),
            onPressed: () async {
              if (_addressController.text.isNotEmpty) {
                if (_saved) setState(() => _saved = false);
                await Prefs.instance
                    .setString('address', _addressController.text);
                setState(() => _saved = true);
              }
            },
          ),
        ),
      ],
    );
  }
}
