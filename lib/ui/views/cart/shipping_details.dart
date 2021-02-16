import 'package:flutter/material.dart';

class ShippingDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShippingDetailsState();
  }
}

class _ShippingDetailsState extends State<ShippingDetails> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

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
                width: MediaQuery.of(context).size.width / 2 - 20,
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First name'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last name'),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address (optional)',
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Note (optional)',
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
                  labelText: 'City: Conakry',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
