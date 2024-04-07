import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenhome/logic/getUserData.dart';
import 'package:http/http.dart' as http;

Future<void> updateUserData(Map<String, dynamic> deviceData) async {
  debugPrint('Updating user data');
  var currentUserData = {};
  await getUserData(1234).then((value) {
    currentUserData = value;
    print('Got - $currentUserData');
  });

  double energyConsumption;
  try {
    energyConsumption = double.parse(deviceData['EnergyConsumption']);
  } catch (e) {
    energyConsumption = 0.1;
  }

  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://python-hello-world-three-wine.vercel.app/api/add-device'));
  currentUserData['devices'].add({
    // 'name': 'Projector',
    'name': 'TV',
    'status': false,
    'hours': 5.0,
    'kwh': energyConsumption / 12 / 30
  });

  List<Map<String, dynamic>> devices = currentUserData['devices'];

  double totalKwh = devices.fold(0.0, (sum, device) {
    return sum + (device['kwh'] ?? 0.0);
  });

  print('Total kWh: $totalKwh');

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

  debugPrint('Sent');

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
