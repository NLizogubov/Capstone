import 'package:capstone/domain/Web/WebService.dart';

class Top250Request extends HTTPRequest {

  @override
  Uri makeURL() {
    return Uri.https('imdb-api.com', '/en/API/Top250Movies/k_2fnvr47k');
  }

}