import 'dart:convert';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class NetworkRequest {
  static const STATUS_OK = 200;

  final Map<String, String> _jsonHeaders = {'content-type': 'application/json'};

  final http.Client client;
  final RequestType type;
  final Uri address;
  final Map<String, dynamic> body;
  Map<String, String> headers;
  final List<int> listBody;
  final String plainBody;

  NetworkRequest(this.type, this.address,
      {required this.client,
      required this.body,
      required this.plainBody,
      required this.listBody,
      required this.headers});

  Future<http.Response> getResult() async {
    print('ADDRESS: $address');
    print('listBody: ${jsonEncode(listBody)}');
    print('plainBody: $plainBody');
    print('body: ${jsonEncode(body)}');
    http.Response response;
    headers ??= _jsonHeaders;
    try {
      Uri uri = address; //Uri.parse(address);
      switch (type) {
        case RequestType.post:
          response = await client.post(
            uri,
            headers: headers,
            body: jsonEncode(body) ?? plainBody ?? listBody,
          );
          break;
        case RequestType.get:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.put:
          response = await client.put(uri,
              body: body ?? plainBody ?? listBody, headers: headers);
          break;
        case RequestType.delete:
          response = await client.delete(uri, headers: headers);
          break;
      }
      print('RESULT: ${response.body}');
      if (response.statusCode != STATUS_OK) {
        throw HttpRequestException();
      }
      return response;
    } catch (exception) {
      if (exception is HttpRequestException) {
        rethrow;
      } else {
        throw RemoteServerException();
      }
    }
  }
}

enum RequestType {
  post,
  get,
  put,
  delete,
}
