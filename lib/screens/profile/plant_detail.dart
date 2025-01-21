import 'package:agrilink/widgets/buttons/back_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlantDetailScreen extends StatefulWidget {
  final String plantName;
  final String imageUrl;
  final String category;
  final String plantDescription;

  const PlantDetailScreen({
    required this.plantName,
    required this.plantDescription,
    required this.imageUrl,
    required this.category,
  });

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    data = [
      _ChartData('Mon', 12),
      _ChartData('Tue', 15),
      _ChartData('Wed', 30),
      _ChartData('Thu', 6.4),
      _ChartData('Fri', 14)
    ];
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Colors.black
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: widget.plantName,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plantName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.category,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: 40,
                          interval: 10,
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CartesianSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                            borderRadius: BorderRadius.circular(10),
                            dataSource: data,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Growth',
                            color: Theme.of(context).colorScheme.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Description about the plant
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.plantDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(
                        alpha: 50
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: BackButtonWidget(),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
