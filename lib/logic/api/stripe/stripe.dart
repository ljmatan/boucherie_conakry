import 'package:stripe_payment/stripe_payment.dart';

abstract class Stripe {
  static void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: '',
        merchantId: '',
        androidPayMode: 'test', // TODO: Set to 'production' for release
      ),
    );
  }
}
