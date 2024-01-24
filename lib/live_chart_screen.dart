import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LiveChartScreen extends StatelessWidget {
  final List<BpmData> bpmData;

  LiveChartScreen({required this.bpmData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Chart'),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: const NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 10, // adjust interval based on your requirement
            title: AxisTitle(text: 'Seconds'),
          ),
          primaryYAxis: const NumericAxis(),
          series: <CartesianSeries>[
            LineSeries<BpmData, int>(
              dataSource: bpmData,
              xValueMapper: (BpmData data, _) => data.seconds,
              yValueMapper: (BpmData data, _) => data.bpm,
            ),
          ],
        ),
      ),
    );
  }
}

class BpmData {
  final int seconds;
  final double bpm;

  BpmData(this.seconds, this.bpm);
}
