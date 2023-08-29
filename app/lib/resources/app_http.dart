import 'package:http/http.dart' as http;

class AppHttp {
  var client = http.Client();

  // static var baseUrl = 'https://lamb-sure-crayfish.ngrok-free.app/api';
  static var baseUrl = 'http://127.0.0.1:8000/api';
}
