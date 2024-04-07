import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getUserData(int userId) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('GET',
      Uri.parse('https://python-hello-world-three-wine.vercel.app/api/user'));
  request.body = json.encode({"user_id": 1234});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    return jsonDecode(responseBody);
  } else {
    throw Exception('Failed to load user data: ${response.reasonPhrase}');
  }
}
