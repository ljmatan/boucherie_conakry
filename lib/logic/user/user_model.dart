import 'package:flutter/widgets.dart';

class UserModel {
  String firstName, lastName, number, username, email, address;
  int id;

  UserModel({
    @required this.firstName,
    @required this.lastName,
    @required this.number,
    @required this.username,
    @required this.email,
    @required this.id,
    this.address,
  });
}
