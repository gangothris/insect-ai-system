import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'result_screen.dart';

class PreviewScreen extends StatelessWidget {
  final File image;

  PreviewScreen(this.image);

  final String BASE_URL = "http://10.105.167.194:8000";

  Future detect(BuildContext context) async {
    // 🔥 loading popup
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$BASE_URL/recommend/'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );

    var response = await request.send();
    final res = await response.stream.bytesToString();
    final data = json.decode(res);

    Navigator.pop(context); // remove loading

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(image),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => detect(context),
                child: Text("Detect Insects"),
              ),
            )
          ],
        ),
      ),
    );
  }
}