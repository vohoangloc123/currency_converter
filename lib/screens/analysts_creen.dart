import 'package:currencyconverter/models/chart_data.dart';
import 'package:currencyconverter/services/fetch_exchange_rates.dart';
import 'package:currencyconverter/widgets/chart_painter.dart';
import 'package:flutter/material.dart';

class AnalystScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange Rate Analyst'),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: fetchExchangeRates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Prepare data for the chart
            List<ChartData> chartData = snapshot.data!.entries.map((entry) {
              return ChartData(entry.key, entry.value);
            }).toList();

            return Center(
              child: CustomPaint(
                size: const Size(
                    double.infinity, 400), // Increase height for better display
                painter: ChartPainter(chartData),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}



