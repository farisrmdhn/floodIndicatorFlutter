// Packages
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import '../models/Input.dart';

class LineChart1 extends StatefulWidget {

  final List<Input> inputs;

  LineChart1({this.inputs});

  @override
  _LineChart1State createState() => _LineChart1State();
}

class _LineChart1State extends State<LineChart1> {
  bool isShowingMainData;

  double last = 0;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16/9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: const [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          // ignore: missing_return
          getTitles: (value) {
            DateTime dateFrom = DateTime.parse(widget.inputs.first.timestamp);
            DateTime dateTo = DateTime.parse(widget.inputs.last.timestamp);
            final DateFormat formatter = DateFormat('MMMd');
            final String newDateFrom = formatter.format(dateFrom);
            final String newDateTo = formatter.format(dateTo);
            if(value == 0) {
              return newDateFrom;
            } else if(value == last) {
              return newDateTo;
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Safe';
              case 2:
                return 'Warning';
              case 3:
                return 'Danger';
              case 4:
                return 'Error';
            }
            return '';
          },
          margin: 8,
          reservedSize: 60,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 30,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    List<FlSpot> spots =  [];
    double x = 0;
    widget.inputs?.forEach((Input input) {
      double y = 0;
      x++;
      if(input.waterLevel == 'Safe') {
        y = 1;
      } else if(input.waterLevel == 'Warning') {
        y = 2;
      } else if(input.waterLevel == 'Danger') {
        y = 3;
      } else {
        y = 4;
      }
      if(x == widget.inputs.length) {
        last = x;
      }
      spots.add(FlSpot(x, y));
    });
    
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: spots,
      isCurved: false,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1
    ];
  }

  
}