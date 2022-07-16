import 'dart:io';

class ConnectionUtils {
  static Future<bool> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');

      return response.isNotEmpty;
    } on SocketException catch (e) {
      return false;
    }
  }

  static Future<bool> isConnected() async {
    return await _tryConnection();
  }
}
