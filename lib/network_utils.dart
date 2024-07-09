import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtils {
  static Stream<ConnectivityResult> get connectivityStream =>
      Connectivity().onConnectivityChanged;

  static void initNetworkListener() {
    connectivityStream.listen((ConnectivityResult result) {
      _handleConnectivityChange(result);
    });
  }

  static void _handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(msg: 'Connected to internet');
    } else {
      Fluttertoast.showToast(msg: 'No internet connection');
    }
  }
}