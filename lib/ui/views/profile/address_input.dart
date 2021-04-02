import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:flutter/material.dart';

class AddressInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddressInputState();
  }
}

class _AddressInputState extends State<AddressInput> {
  final _addressController =
      TextEditingController(text: Prefs.instance.getString('address') ?? '');

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
                FocusScope.of(context).unfocus();
                if (_saved) setState(() => _saved = false);
                await Prefs.instance
                    .setString('address', _addressController.text);
                UserData.instance.address = _addressController.text;
                setState(() => _saved = true);
              }
            },
          ),
        ),
      ],
    );
  }
}
