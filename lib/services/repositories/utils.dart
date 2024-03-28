import 'package:my_profile/config/server_addresses.dart';
import 'package:my_profile/config/storage.dart';

class HttpClient {
  Map createHeader() {
    var header = <String, String>{
      'authorization': 'Bearer ${Storage().token}',
    };
    return header;
  }

  Uri createUri(String route, [Map<String, String> param = const {}]) {
    return Uri(
      scheme: 'https',
      host: ServerAddresses.serverAddress,
      path: route,
      queryParameters: param,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
