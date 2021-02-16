import 'user_model.dart';
import 'package:boucherie_conakry/logic/cache/prefs.dart';

abstract class UserData {
  static UserModel _instance = UserModel(
    firstName: Prefs.instance.getString('firstName'),
    lastName: Prefs.instance.getString('lastName'),
    username: Prefs.instance.getString('username'),
    email: Prefs.instance.getString('email'),
    id: Prefs.instance.getInt('id'),
  );

  static UserModel get instance => _instance;

  static Future<void> setInstance(
    String firstName,
    String lastName,
    String username,
    String email,
    int id,
  ) async {
    _instance = UserModel(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      id: id,
    );

    await Prefs.instance.setString('firstName', firstName);
    await Prefs.instance.setString('lastName', lastName);
    await Prefs.instance.setString('username', username);
    await Prefs.instance.setString('email', email);
    await Prefs.instance.setInt('id', id);
  }
}
