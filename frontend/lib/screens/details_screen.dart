// details_screen.dart

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final data;

  DetailsScreen(this.data);

  Widget buildCard(String title, String content) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text(content),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rec = data['recommendation'];

    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildCard("Treatment", rec['treatment']),
            buildCard("Prevention", rec['prevention']),
          ],
        ),
      ),
    );
  }
}