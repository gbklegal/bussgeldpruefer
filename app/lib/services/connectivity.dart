import 'package:connectivity/connectivity.dart';

class ConnectionStatus {
  // ignore: missing_return
  Future<bool> checkConnectionStatus() async {
    var conResult = await (Connectivity().checkConnectivity());
    if (conResult == ConnectivityResult.mobile ||
        conResult == ConnectivityResult.wifi) {
      return true;
    } else if (conResult == ConnectivityResult.none) {
      return false;
    }
  }
}
