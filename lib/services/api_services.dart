import 'package:http/http.dart' as http;

class ApiServices{
  Future<http.Response> getReq(String apiEndPoint) async {
    return await http.get(Uri.parse(apiEndPoint), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    }).timeout(const Duration(seconds: 15));
  }
}