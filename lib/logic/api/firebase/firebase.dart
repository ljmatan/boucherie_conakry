import 'dart:convert';

import 'package:boucherie_conakry/logic/local_db/local_db.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:http/http.dart' as http;

abstract class FirebaseAPI {
  static final _url = Uri.parse(
      'https://boucherieconakry-4571d-default-rtdb.europe-west1.firebasedatabase.app/orders/${UserData.instance.id}.json');

  static Future<void> updateOrders(Map newOrder) async =>
      await http.post(_url, body: jsonEncode(newOrder));

  static Future<void> retrieveOrders() async {
    final response = await http.get(_url);

    final Map data = jsonDecode(response.body);

    if (data != null)
      for (var key in data.keys)
        await LocalDB.instance.insert(
          'Orders',
          {
            'orderJsonEncoded': jsonEncode(data[key]['orderJsonEncoded']),
          },
        );
  }
}
