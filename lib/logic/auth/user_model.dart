import 'package:flutter/widgets.dart';

class UserModel {
  final String firstName, lastName, username, email;
  final int id;

  UserModel({
    @required this.firstName,
    @required this.lastName,
    @required this.username,
    @required this.email,
    @required this.id,
  });
}
