import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:flutter/material.dart';

class ResetPasswordButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordButtonState();
  }
}

class _ResetPasswordButtonState extends State<ResetPasswordButton> {
  bool _sending = false;
  bool _sent = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: SizedBox(
          height: 48,
          child: Center(
            child: _sending
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    _sent
                        ? I18N.text('instructions sent to email')
                        : I18N.text('reset password'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
      onTap: () async {
        setState(() => _sending = true);
        await WoocommerceAPI.sendPasswordResetEmail(UserData.instance.email);
        setState(() {
          _sending = false;
          _sent = true;
        });
      },
    );
  }
}
