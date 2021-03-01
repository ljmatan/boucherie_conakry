import 'dart:convert';

import 'package:boucherie_conakry/logic/api/firebase/firebase.dart';
import 'package:boucherie_conakry/logic/api/woocommerce/woocommerce.dart';
import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:boucherie_conakry/logic/i18n/i18n.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'login_success_dialog.dart';
import 'package:flutter/material.dart';

class LoginDisplay extends StatefulWidget {
  final Function(int) goToPage;

  LoginDisplay({@required this.goToPage});

  @override
  State<StatefulWidget> createState() {
    return _LoginDisplayState();
  }
}

class _LoginDisplayState extends State<LoginDisplay> {
  final _usernameController = TextEditingController();
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    autofocus: true,
                    enabled: !_verifying,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: I18N.text('email or username'),
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
                              I18N.text('register'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: _verifying ? null : () => widget.goToPage(0),
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
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : Text(
                                    I18N.text('login'),
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
                              if (_usernameController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                try {
                                  FocusScope.of(context).unfocus();
                                  setState(() => _verifying = true);
                                  final response = await WoocommerceAPI.login(
                                      _usernameController.text,
                                      _passwordController.text);
                                  if (jsonDecode(response.body)['token'] !=
                                      null) {
                                    final idResponse =
                                        await WoocommerceAPI.getUserID(
                                            jsonDecode(response.body)['token']);
                                    await Prefs.instance.setInt('id',
                                        jsonDecode(idResponse.body)['id']);
                                    final Map userData =
                                        await WoocommerceAPI.getCustomerByID();
                                    await UserData.setInstance(
                                      userData['first_name'],
                                      userData['last_name'],
                                      userData['username'],
                                      userData['email'],
                                      userData['id'],
                                      userData['shipping']['address_1'],
                                    );
                                    try {
                                      await FirebaseAPI.retrieveOrders();
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                    setState(() => _verifying = false);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        barrierColor: Colors.transparent,
                                        builder: (context) =>
                                            LoginSuccessDialog());
                                  } else {
                                    setState(() => _verifying = false);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(jsonDecode(
                                            response.body)['message'])));
                                  }
                                } catch (e) {
                                  setState(() => _verifying = false);
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('$e')));
                                }
                              } else
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        I18N.text('please check your input'))));
                            },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: Center(
                        child: Text(
                          I18N.text('forgot password?'),
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                    onTap: _verifying ? null : () => widget.goToPage(2),
                  ),
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
    _passwordController.dispose();
    super.dispose();
  }
}
