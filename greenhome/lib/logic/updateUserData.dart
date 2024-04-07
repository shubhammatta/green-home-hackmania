import 'dart:convert';
import 'package:greenhome/logic/getUserData.dart';
import 'package:http/http.dart' as http;

Future<void> updateUserData(Map<String, dynamic> deviceData) async {
  var currentUserData = {};
  await getUserData(1234).then((value) {
    currentUserData = value;
    print('Got - $currentUserData');
  });

  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://python-hello-world-three-wine.vercel.app/api/add-device'));
  currentUserData['devices'].add({
    'name': 'Projector',
    'status': false,
    'hours': 3.0,
    'kwh': deviceData['EnergyConsumption'] / 12 / 30
  });

  double totalKwh = currentUserData['devices'].fold(0.0, (sum, device) {
    return sum + (currentUserData['devices']['kwh'] ?? 0.0);
  });
  print('valueis   $totalKwh');

  request.body = json.encode({
    "user_id": 1234,
    "layout": "1-Bedroom",
    "agency": "HDB",
    "location": {"lat": "", "long": ""},
    "number_of_devices": 0,
    "daily_projected_bill": 0,
    "cost_per_kwh": 0.29,
    "devices": currentUserData['devices']
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
