import 'package:boucherie_conakry/logic/api/woocommerce/payment_gateway_model.dart';

abstract class PaymentGateways {
  static List<PaymentGateway> _instance;
  static List<PaymentGateway> get instance => _instance;

  static void setInstance(List<PaymentGateway> value) => _instance = value;
}
