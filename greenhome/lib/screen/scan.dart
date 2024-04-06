import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ScanAppliance extends StatefulWidget {
  const ScanAppliance({super.key});

  @override
  _ScanApplianceState createState() => _ScanApplianceState();
}

class _ScanApplianceState extends State<ScanAppliance> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;

  Future<void> _captureImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image != null ? File(image.path) : null;
    });
  }

  Future<void> _sendImageToApi() async {
    if (_imageFile == null) {
      print('No image captured');
      return;
    }

    const String apiUrl = 'https://example.com/api/upload';
    final uri = Uri.parse(apiUrl);
    final request = http.MultipartRequest('POST', uri);
    request.files
        .add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      // Handle the API response here
    } else {
      print('Failed to upload image. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture and Send Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 200,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _captureImage,
              child: const Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: _sendImageToApi,
              child: const Text('Send Image to API'),
            ),
          ],
        ),
      ),
    );
  }
}
