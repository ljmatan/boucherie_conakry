import 'package:flutter/widgets.dart';

class OrderItemModel {
  final String name, category;
  final int price, id;
  int quantity, portion, variationID;

  OrderItemModel({
    @required this.name,
    @required this.category,
    @required this.id,
    @required this.price,
    @required this.quantity,
    this.portion,
    this.variationID,
  });
}
