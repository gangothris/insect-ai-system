import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'analytics_screen.dart';

class ResultScreen extends StatelessWidget {
  final dynamic data;

  ResultScreen(this.data);

  Color getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      case "low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = data['summary'];
    final recommendation = data['recommendation'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Detection Result"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔥 Annotated Image
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  data['annotated_image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔥 Summary Card
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      summary['dominant_insect'].toUpperCase(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Detected: ${summary['total_detections']}",
                      style: TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Confidence: ${summary['avg_confidence']}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                    SizedBox(height: 15),

                    // 🔥 Severity Badge
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: getSeverityColor(
                                recommendation['severity'])
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        recommendation['severity'].toUpperCase(),
                        style: TextStyle(
                          color: getSeverityColor(
                              recommendation['severity']),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔥 Buttons Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: [

                  // Details Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.info),
                      label: Text("View Details"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(data),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  // Analytics Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.bar_chart),
                      label: Text("View Analytics"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(14),
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnalyticsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}