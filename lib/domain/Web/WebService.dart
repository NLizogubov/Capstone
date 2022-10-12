import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class HTTPRequest {
  Uri makeURL();
}

abstract class WebService {
  Future<Map<String, dynamic>> perform(HTTPRequest request);
}

class WebServiceImpl implements WebService {

  @override
  Future<Map<String, dynamic>> perform(HTTPRequest request) async {
    final response = await http.get(request.makeURL());
    final json = jsonDecode(response.body);

    return json;
  }

}