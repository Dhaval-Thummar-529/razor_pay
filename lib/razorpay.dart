import 'package:razor_pay/razorpay_api_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayIntegration {
  final Razorpay _razorPay = Razorpay();

  initiateRazorPay(Function callBack) {
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) => {callBack("Payment Success")});
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (response) => {callBack("Payment Failed")});
    // _razorPay.on(Razorpay., _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {}

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  openSession({required num amount}) {
    createOrder(amount: amount).then((orderId) {
      print(orderId);
      if (orderId.toString().isNotEmpty) {
        var options = {
          'key': "rzp_test_hJboby3u39xEsW",
          'amount': amount,
          'name': 'Dhaval',
          'order_id': orderId,
          'description': "Description For Order",
          'timeout': 600,
          'prefill': {
            'contact': '8849773158',
            'email': 'dhavalmpatel529@gmail.com'
          }
        };
        _razorPay.open(options);
      } else {}
    });
  }

  createOrder({required num amount}) async {
    final myData = await RazorPayApiService().razorPayApi(amount, "rcp_id_1");
    if (myData['status'] == "success") {
      print(myData);
      return myData['body']['id'];
    } else {
      return "";
    }
  }
}
