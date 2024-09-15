import 'package:agrilink/theme/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarketChart extends StatefulWidget {
  final Map<String, dynamic> chartData; // Accept JSON data
  final String produceName; // Produce name to be displayed
  final bool showXAxis; // Flag to show/hide x-axis values
  final bool showYAxis; // Flag to show/hide y-axis values

  const MarketChart({
    Key? key,
    required this.chartData,
    required this.produceName,
    this.showXAxis = true,
    this.showYAxis = true, // Default to true
  }) : super(key: key);

  @override
  State<MarketChart> createState() => _MarketChartState();
}

class _MarketChartState extends State<MarketChart> {
  List<Color> gradientColors = [
    colorScheme.primary,
    colorScheme.error,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.produceName, // Display produce name
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 10),
        Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.70,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  showAvg ? avgData() : mainData(),
                ),
              ),
            ),
            SizedBox(
              width: 60,
              height: 34,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAvg = !showAvg;
                  });
                },
                child: Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Parse JSON data into FlSpot for the chart
  List<FlSpot> getSpotsFromData() {
    List<FlSpot> spots = [];
    List<dynamic> dataPoints = widget.chartData['dataPoints'];

    print('Data Points: $dataPoints');

    for (var point in dataPoints) {
      spots.add(FlSpot(
        point['x'].toDouble(),
        point['y'].toDouble(),
      ));
    }
    return spots;
  }

  // Calculate the min and max values for X and Y based on the input data
  double getMinX() {
    List<dynamic> dataPoints = widget.chartData['dataPoints'];
    return dataPoints
        .map((point) => point['x'])
        .reduce((a, b) => a < b ? a : b)
        .toDouble();
  }

  double getMaxX() {
    List<dynamic> dataPoints = widget.chartData['dataPoints'];
    return dataPoints
        .map((point) => point['x'])
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
  }

  double getMinY() {
    List<dynamic> dataPoints = widget.chartData['dataPoints'];
    return dataPoints
        .map((point) => point['y'])
        .reduce((a, b) => a < b ? a : b)
        .toDouble();
  }

  double getMaxY() {
    List<dynamic> dataPoints = widget.chartData['dataPoints'];
    return dataPoints
        .map((point) => point['y'])
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(), // Use raw x-axis value as string
        style: style,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Text(
      value.toInt().toString(), // Use raw y-axis value as string
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.onPrimary,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: colorScheme.onPrimary,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: widget.showXAxis, // Control x-axis display
            reservedSize: 30,
            interval: 8,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: widget.showYAxis, // Control y-axis display
            interval: 50,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: getMinX(), // Set dynamic min X
      maxX: getMaxX(), // Set dynamic max X
      minY: getMinY(), // Set dynamic min Y
      maxY: getMaxY(), // Set dynamic max Y
      lineBarsData: [
        LineChartBarData(
          spots: getSpotsFromData(), // Use dynamic data from JSON
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: widget.showXAxis, // Control x-axis display
              reservedSize: 30,
              getTitlesWidget: bottomTitleWidgets,
              interval: 7),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: widget.showYAxis, // Control y-axis display
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
              interval: 50),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: getMinX(), // Set dynamic min X
      maxX: getMaxX(), // Set dynamic max X
      minY: getMinY(), // Set dynamic min Y
      maxY: getMaxY(), // Set dynamic max Y
      lineBarsData: [
        LineChartBarData(
          spots: getSpotsFromData(), // Use dynamic data from JSON
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
