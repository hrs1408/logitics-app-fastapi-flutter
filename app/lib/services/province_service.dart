import 'package:http/http.dart' as http;

class ProvinceService {
  Future<dynamic> getAllProvince(String tokne) async {
    var response =
        await http.get(Uri.parse("https://provinces.open-api.vn/api/"));
    return response;
  }
}
