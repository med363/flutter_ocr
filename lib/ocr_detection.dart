import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  int OCR_CAM = FlutterMobileVision.CAMERA_BACK;
  String scannedText = "Scanned Text Here";

  Future<void> _scan() async {
    List<OcrText> words = [];
    try {
      words = await FlutterMobileVision.read(
        camera: OCR_CAM,
        waitTap: true,
      );

      setState(() {
        scannedText = words[0].value;
      });
    } on Exception {
      setState(() {
        scannedText = 'Unable to recognize the text';
      });
    }
  }

  Future<void> _uploadImage() async {
    if (scannedText.toLowerCase().contains('medical')) {
      // Replace this with your actual image upload logic
      // For example:
      // await uploadFunction();
      setState(() {
        scannedText = "Image uploaded";
      });
    } else {
      setState(() {
        scannedText = "Text does not contain 'medical'";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Scan and Upload'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: _scan,
                  child: const Text(
                    'Scan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Scanned Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                scannedText,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: OCRPage()));
}
