import 'dart:convert';

import 'package:boucherie_conakry/global/current_order/current_order.dart';
import 'package:boucherie_conakry/global/products.dart';
import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:boucherie_conakry/logic/user/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:boucherie_conakry/logic/api/woocommerce/products_model.dart';

abstract class WoocommerceAPI {
  static const String _consumerKey =
      'ck_1cb57f5bf24d509c790d358aa924ad737c56e6dd';
  static const String _consumerSecret =
      'cs_ee6f4f4bb093a0c75dd71bbd2357421454c50d94';

  static String _restParameter;
  static String get _url =>
      'https://boucherieconakry.com/wp-json/wc/v2/$_restParameter?'
      'consumer_key=$_consumerKey&consumer_secret=$_consumerSecret';

  static Future<List<Product>> getSpecialties() async {
    _restParameter = 'products';
    const String filters = '&per_page=100&category=107';

    final response = await http.get(Uri.parse(_url + filters));

    final List<Product> specialties = productsFromJson(response.body);

    Products.setSpecialties(specialties);

    return specialties;
  }

  static Future<List<Product>> getWines([int filter]) async {
    _restParameter = 'products';
    const String filters = '&per_page=100&category=115,113,116,114';

    List<Product> wines;

    if (Products.wines == null) {
      final response = await http.get(Uri.parse(_url + filters));
      wines = productsFromJson(response.body);
    } else
      wines = List.from(Products.wines);

    if (filter != null)
      wines.removeWhere((product) => product.categories.first.id != filter);

    if (filter == null) Products.setWines(wines);

    return wines;
  }

  static Future<List<Product>> getSeafood() async {
    _restParameter = 'products';
    const String filters = '&per_page=100&category=82';

    final response = await http.get(Uri.parse(_url + filters));

    final List<Product> seafood = productsFromJson(response.body);

    Products.setSeafood(seafood);

    return seafood;
  }

  static Future<List<Product>> getButchers([int filter]) async {
    _restParameter = 'products';
    const String filters = '&per_page=100&category=96,93,84,111,62,100,72,15';

    List<Product> butchers;

    if (Products.butchers == null) {
      final response = await http.get(Uri.parse(_url + filters));
      butchers = productsFromJson(response.body);
    } else
      butchers = List.from(Products.butchers);

    if (filter != null)
      butchers.removeWhere((product) => product.categories.first.id != filter);

    if (filter == null) Products.setButchers(butchers);

    return butchers;
  }

  static Future<List<Product>> getFeatured() async {
    _restParameter = 'products';
    const String filters = '&per_page=100&featured=true';

    final response = await http.get(Uri.parse(_url + filters));

    final List<Product> featured = productsFromJson(response.body);

    Products.setFeatured(featured);

    return featured;
  }

  static Future<http.Response> login(String username, String password) async =>
      await http.post(
        Uri.parse('https://boucherieconakry.com/wp-json/jwt-auth/v1/token'),
        body: {'username': username, 'password': password},
      );

  static Future<http.Response> getUserID(String token) async => await http.get(
          Uri.parse('https://boucherieconakry.com/wp-json/wp/v2/users/me'),
          headers: {
            'Authorization': 'Bearer $token',
          });

  static Future<Map> getCustomerByID() async {
    _restParameter = 'customers/' + Prefs.instance.getInt('id').toString();

    final response = await http.get(Uri.parse(_url));

    return jsonDecode(response.body);
  }

  static Future<http.Response> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    _restParameter = 'customers';

    final response = await http.post(Uri.parse(_url), body: {
      'first_name': firstName,
      'last_name': lastName,
      'username': firstName + lastName,
      'email': email,
      'password': password,
    });

    return response;
  }

  static Future<http.Response> sendPasswordResetEmail(String username) async =>
      await http.get(Uri.parse(
          'https://boucherieconakry.com/api/forgot_password.php?login=' +
              username));

  static Future<http.Response> newOrder(
    String firstName,
    String lastName,
    String number,
    String address,
    String coupon,
    String note,
  ) async {
    _restParameter = 'orders';

    final response = await http.post(
      Uri.parse(_url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(
        {
          'payment_method': 'cod',
          'payment_method_title': 'Paiement à la livraison',
          'set_paid': false,
          'billing': {
            'first_name': firstName,
            'last_name': lastName,
            'address_1': address,
            'email': UserData.instance.email ?? 'unregistered@anonymous.com',
            'phone': number,
          },
          'shipping': {
            'first_name': firstName,
            'last_name': firstName,
            'address_1': address,
          },
          'line_items': [
            for (var product in CurrentOrder.instance)
              {
                'product_id': product.id,
                'quantity': product.quantity,
                if (product.variationID != null)
                  'variation_id': product.variationID,
              },
          ],
          if (coupon.isNotEmpty)
            'coupon_lines': [
              {'code': coupon}
            ],
          if (note.isNotEmpty) 'customer_note': note,
        },
      ),
    );

    return response;
  }
}
