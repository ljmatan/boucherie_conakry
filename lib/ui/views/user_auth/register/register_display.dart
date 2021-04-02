import 'dart:convert';

import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/html_parsing/string_processing.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'register_success_dialog.dart';
import 'package:flutter/material.dart';

class RegisterDisplay extends StatefulWidget {
  final Function(int) goToPage;

  RegisterDisplay({@required this.goToPage});

  @override
  State<StatefulWidget> createState() {
    return _RegisterDisplayState();
  }
}

class _RegisterDisplayState extends State<RegisterDisplay> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _verifying = false;

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: TextField(
                          autofocus: true,
                          enabled: !_verifying,
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: I18N.text('first name'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: TextField(
                          enabled: !_verifying,
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: I18N.text('last name'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    enabled: !_verifying,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      enabled: !_verifying,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: I18N.text('password'),
                      ),
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
                              I18N.text('login'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: _verifying ? null : () => widget.goToPage(1),
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
                            child: _verifying
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
                                    I18N.text('register'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      onTap: _verifying
                          ? null
                          : () async {
                              if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(_emailController.text)) {
                                setState(() => _verifying = true);

                                try {
                                  final response =
                                      await WoocommerceAPI.register(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                  );

                                  if (response.statusCode == 201) {
                                    setState(() => _verifying = false);

                                    await UserData.setInstance(
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _firstNameController.text +
                                          _lastNameController.text,
                                      _emailController.text,
                                      jsonDecode(response.body)['id'],
                                    );

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      barrierColor: Colors.transparent,
                                      builder: (context) =>
                                          RegisterSuccessDialog(
                                              _firstNameController.text),
                                    );
                                  } else {
                                    setState(() => _verifying = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(StringProcessing
                                                .removeAllHtmlTags(
                                                    jsonDecode(response.body)[
                                                        'message']))));
                                  }
                                } catch (e) {
                                  setState(() => _verifying = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('$e')));
                                }
                              } else
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(I18N.text('email invalid'))));
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
