import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final String BASE_URL = "http://10.105.167.194:8000";

  List analyticsData = [];

  @override
  void initState() {
    super.initState();
    fetchAnalytics();
  }

  Future fetchAnalytics() async {
    final res = await http.get(Uri.parse("$BASE_URL/analytics/"));
    final data = json.decode(res.body);

    setState(() {
      analyticsData = data["analytics"];
    });
  }

  // 🔥 CLEAN MAX Y
  double getMaxY() {
    final max = analyticsData
        .map((e) => e["count"])
        .reduce((a, b) => a > b ? a : b);

    return (max + 10).toDouble(); // padding
  }

  // 🔥 CLEAN INTERVAL
  double getInterval() {
    final max = analyticsData
        .map((e) => e["count"])
        .reduce((a, b) => a > b ? a : b);

    return (max / 5).ceilToDouble();
  }

  // 🔥 BARS WITH GRADIENT
  List<BarChartGroupData> buildBars() {
    return List.generate(analyticsData.length, (index) {
      final item = analyticsData[index];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item["count"].toDouble(),
            width: 22,
            borderRadius: BorderRadius.circular(8),

            // 🔥 PREMIUM LOOK
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Analytics")),
      body: analyticsData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // 🔥 BAR CHART (FIXED)
                  SizedBox(
                    height: 260,
                    child: BarChart(
                      BarChartData(
                        maxY: getMaxY(),
                        barGroups: buildBars(),

                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),

                        borderData: FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          // 🔥 Y AXIS (clean numbers)
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: getInterval(),
                              reservedSize: 32,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(fontSize: 11),
                                );
                              },
                            ),
                          ),

                          // 🔥 X AXIS (insects)
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= analyticsData.length) {
                                  return SizedBox();
                                }

                                return Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    analyticsData[index]["insect"],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Insect Distribution",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: analyticsData.length,
                      itemBuilder: (context, index) {
                        final item = analyticsData[index];

                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.bug_report,
                              color: Colors.deepPurple,
                            ),
                            title: Text(
                              item["insect"],
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              "Count: ${item["count"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}