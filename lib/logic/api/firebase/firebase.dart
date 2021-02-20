import 'dart:convert';

import 'package:boucherie_conakry/logic/local_db/local_db.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:http/http.dart' as http;

abstract class FirebaseAPI {
  static Future<void> updateOrders(Map newOrder) async {
    final response = await http.post(
      'https://boucherieconakry-4571d-default-rtdb.europe-west1.firebasedatabase.app/orders/${UserData.instance.id}.json',
      body: jsonEncode(newOrder),
    );

    print(jsonDecode(response.body));
  }

  static Future<void> retrieveOrders() async {
    final response = await http.get(
      'https://boucherieconakry-4571d-default-rtdb.europe-west1.firebasedatabase.app/orders/${UserData.instance.id}.json',
    );

    final Map data = jsonDecode(response.body);

    print(data);

    for (var key in data.keys)
      await LocalDB.instance.insert(
        'Orders',
        {
          'orderJsonEncoded': jsonEncode(data[key]['orderJsonEncoded']),
        },
      );
  }
}
