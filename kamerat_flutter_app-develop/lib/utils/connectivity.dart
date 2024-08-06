import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

Future<bool> checkInternetConnection() async {
  ConnectivityResult result = await Connectivity().checkConnectivity();
  return result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi;
}

Future<bool> checkInternetAccess() async {
  try {
    if (await checkInternetConnection()) {
      http.Response response = await http
          .get(Uri.parse("https://www.google.com/"))
          .timeout(const Duration(seconds: 10));
      return response.body.isNotEmpty;
    }
  } catch (_) {}
  return false;
}
