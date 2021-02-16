import 'dart:async';

import 'forgot_password/forgot_password_display.dart.dart';
import 'register_display.dart';
import 'login_display.dart';
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: StreamBuilder(
          stream: _titleController.stream,
          initialData: widget.page,
          builder: (context, page) => Text(
            page.data == 0
                ? 'Register'
                : page.data == 1
                    ? 'Login'
                    : 'Forgot password',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            splashColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
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
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleController.close();
    super.dispose();
  }
}
