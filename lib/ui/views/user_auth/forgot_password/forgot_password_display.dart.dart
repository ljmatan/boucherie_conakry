import 'dart:convert';

import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';

import 'reset_success_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDisplay extends StatefulWidget {
  final Function(int) goToPage;

  ForgotPasswordDisplay({@required this.goToPage});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordDisplayState();
  }
}

class _ForgotPasswordDisplayState extends State<ForgotPasswordDisplay> {
  final _usernameController = TextEditingController();

  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(I18N.text('forgot password description')),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      autofocus: true,
                      enabled: !_sending,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: I18N.text('email or username'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 16,
                          height: 48,
                          child: Center(
                            child: Text(
                              I18N.text('back'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: _sending ? null : () => widget.goToPage(1),
                    ),
                    GestureDetector(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 16,
                          height: 48,
                          child: Center(
                            child: _sending
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    I18N.text('reset'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      onTap: _sending
                          ? null
                          : () async {
                              try {
                                FocusScope.of(context).unfocus();
                                setState(() => _sending = true);
                                final response =
                                    await WoocommerceAPI.sendPasswordResetEmail(
                                  _usernameController.text,
                                );
                                if (mounted &&
                                    response.body.contains('has been sent')) {
                                  setState(() => _sending = false);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => ResetSuccessDialog(),
                                  );
                                } else if (mounted) {
                                  setState(() => _sending = false);
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        const JsonCodec()
                                            .decode(response.body)['msg'],
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  setState(() => _sending = false);
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.toString(),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
