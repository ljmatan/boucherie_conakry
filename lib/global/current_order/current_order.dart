import 'package:boucherie_conakry/global/current_order/order_item_model.dart';
import 'package:boucherie_conakry/ui/views/home/bloc/cart_items_number_controller.dart';

abstract class CurrentOrder {
  static List<OrderItemModel> _instance = [];
  static List<OrderItemModel> get instance => _instance;

  static void addToOrder(OrderItemModel item) {
    _instance.add(item);
    CartItemsNumberController.change(_instance.length);
  }

  static void removeFromOrder(int productID) {
    _instance.removeWhere((item) => item.id == productID);
    CartItemsNumberController.change(_instance.length);
  }

  static void clearAll() {
    _instance.clear();
    CartItemsNumberController.change(0);
  }
}
