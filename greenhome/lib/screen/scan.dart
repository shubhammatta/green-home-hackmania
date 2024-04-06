import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

class ScanAppliance extends StatefulWidget {
  const ScanAppliance({super.key});

  @override
  _ScanApplianceState createState() => _ScanApplianceState();
}

class _ScanApplianceState extends State<ScanAppliance> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  bool isWaiting = false;

  Future<void> _captureImage() async {
    await dotenv.load();
    print(dotenv.env['API_ENDPOINT']);
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image != null ? File(image.path) : null;
    });
  }

  Future<void> _sendImageToApi() async {
    await dotenv.load(fileName: '.env');
    String apiEndPoint = dotenv.env['API_ENDPOINT']!;
    var image = const AssetImage('asset/images/sony.jpeg');
    print(image.keyName);

    // final byteData = await rootBundle.load('asset/images/sony.jpeg');
    // final buffer = byteData.buffer;
    // final directory = await getTemporaryDirectory();
    // final filePath = '${directory.path}/tempImage';
    // final file = await File(filePath).writeAsBytes(
    //     buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    var headers = {'category': 'Projector'};
    var request = http.MultipartRequest('POST', Uri.parse(apiEndPoint));
    print("ABCDC" + _imageFile!.path);
    request.files
        .add(await http.MultipartFile.fromPath('image_path', _imageFile!.path));
    request.headers.addAll(headers);
    try {
      setState(() {
        isWaiting = true;
      });
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        if (mounted) {
          Navigator.pop(context, result);
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {
        isWaiting = false;
      });
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
            // const Image(image: AssetImage('asset/images/sony.jpeg')),
            ElevatedButton(
              onPressed: _captureImage,
              child: const Text('Capture Image'),
            ),
            isWaiting
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _sendImageToApi,
                    child: const Text('Send Image to API'),
                  ),
          ],
        ),
      ),
    );
  }
}
