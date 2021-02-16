import 'dart:async';

abstract class CartItemsNumberController {
  static int _numberOfOrders = 0;
  static int get numberOfOrders => _numberOfOrders;

  static StreamController _streamController;

  static void init() => _streamController = StreamController.broadcast();

  static Stream get stream => _streamController.stream;

  static void change(value) {
    _streamController.add(value);
    _numberOfOrders = value;
  }

  static void dispose() {
    _streamController.close();
    _numberOfOrders = 0;
  }
}
