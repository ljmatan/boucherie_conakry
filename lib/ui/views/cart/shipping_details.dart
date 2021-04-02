import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:flutter/material.dart';

class ShippingDetails extends StatelessWidget {
  final TextEditingController firstNameController,
      lastNameController,
      numberController,
      addressController,
      noteController;

  ShippingDetails({
    @required this.firstNameController,
    @required this.lastNameController,
    @required this.numberController,
    @required this.addressController,
    @required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 21,
                child: TextField(
                  controller: firstNameController,
                  decoration:
                      InputDecoration(labelText: I18N.text('first name')),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 21,
                child: TextField(
                  controller: lastNameController,
                  decoration:
                      InputDecoration(labelText: I18N.text('last name')),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: I18N.text('phone number'),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: I18N.text('address optional'),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: I18N.text('note optional'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: I18N.text('city') + ': Conakry',
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
