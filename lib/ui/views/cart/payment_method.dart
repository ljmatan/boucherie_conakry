import 'package:boucherie_conakry/other/custom_icons.dart';
import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function setPaymentMethod;

  PaymentOption({
    @required this.label,
    @required this.icon,
    @required this.setPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 18),
              ),
              Icon(icon),
            ],
          ),
        ),
      ),
      onTap: () {
        setPaymentMethod(label, icon);
        Navigator.pop(context);
      },
    );
  }
}

class PaymentMethodSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodSelectionState();
  }
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
  String _paymentLabel = 'Cash on delivery';
  IconData _paymentIcon = CustomIcons.money_bill;

  void _setPaymentMethod(String label, IconData icon) => setState(() {
        _paymentLabel = label;
        _paymentIcon = icon;
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: GestureDetector(
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: kElevationToShadow[2],
            color: Colors.white,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 56,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _paymentLabel,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Icon(_paymentIcon),
                ],
              ),
            ),
          ),
        ),
        onTap: () => showModalBottomSheet(
          elevation: 16,
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) => DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PaymentOption(
                  label: 'Cash on Delivery',
                  icon: CustomIcons.money_bill,
                  setPaymentMethod: _setPaymentMethod,
                ),
                const Divider(height: 0),
                PaymentOption(
                  label: 'PayPal',
                  icon: CustomIcons.cc_paypal,
                  setPaymentMethod: _setPaymentMethod,
                ),
                const Divider(height: 0),
                PaymentOption(
                  label: 'Stripe / Credit Card',
                  icon: CustomIcons.cc_stripe,
                  setPaymentMethod: _setPaymentMethod,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
