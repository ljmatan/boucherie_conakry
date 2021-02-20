import 'dart:async';

import 'package:boucherie_conakry/logic/i18n/i18n.dart';

import 'forgot_password/forgot_password_display.dart.dart';
import 'register/register_display.dart';
import 'login/login_display.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final int page;

  AuthPage(this.page);

  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  PageController _pageController;

  final StreamController _titleController = StreamController.broadcast();

  int _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.page);
    _currentPage = widget.page;
    _pageController.addListener(() {
      if (_currentPage != _pageController.page.round()) {
        _currentPage = _pageController.page.round();
        _titleController.add(_currentPage);
      }
    });
  }

  void _animateToPage(int page) {
    FocusScope.of(context).unfocus();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: StreamBuilder(
            stream: _titleController.stream,
            initialData: widget.page,
            builder: (context, page) => Text(
              page.data == 0
                  ? I18N.text('register page title')
                  : page.data == 1
                      ? I18N.text('login page title')
                      : I18N.text('forgot password page title'),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              splashColor: Colors.transparent,
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            RegisterDisplay(goToPage: _animateToPage),
            LoginDisplay(goToPage: _animateToPage),
            ForgotPasswordDisplay(goToPage: _animateToPage),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.close();
    super.dispose();
  }
}
