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

  final GlobalKey<FormState> _formKey = GlobalKey();

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
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: TextField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Last name',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (email) {
                        if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(email))
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Email invalid')),
                          );
                        return;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                              'LOGIN',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () => widget.goToPage(1),
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
                            child: Text(
                              'REGISTER',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {},
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
