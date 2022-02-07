import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  NetworkHelper(this.url);
  Future<String> getDataValue() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      // /  print("data value is $data");
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
