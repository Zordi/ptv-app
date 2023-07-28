import 'dart:convert';
import 'package:http/http.dart' as http;

String countryName = "###";

Future<void> getCountry() async {
  String apiKey = "f0fe2ec6272c4777ad2f130265358c88";
  String url = "https://api.ipgeolocation.io/ipgeo?apiKey=$apiKey";
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  );
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    countryName = body["country_name"];
    print("Country : $countryName");
  } else {
    print("Country : ${response.body}");
  }
}
