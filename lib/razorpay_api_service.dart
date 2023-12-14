import 'dart:convert';
import 'package:http/http.dart' as http;

class RazorPayApiService {

  final razorPayKey = "rzp_test_hJboby3u39xEsW";
  final razorPaySecret = "OV2ljHiwuSSYrc7iVlsrhliQ";

  razorPayApi(num amount, String receiptId) async {
    var auth = "Basic " + base64Encode(utf8.encode("$razorPayKey:$razorPaySecret"));
    var headers = {'content-type': 'application/json', 'Authorization': auth};
    var request = http.Request('POST', Uri.parse("https://api.razorpay.com/v1/orders"));
    request.body = json.encode({
      "amount": amount * 100,
      "currency": "INR",
      "receipt": receiptId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("Api Response Code: ${response.statusCode}");
    if(response.statusCode==200){
      return {
        "status": "success",
        "body": jsonDecode(await response.stream.bytesToString())
      };
    } else {
      return {
        "status": "fail",
        "message": (response.reasonPhrase)
      };
    }
  }

}