import 'dart:core';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/dashboard_data/dashboard_data.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/flutter_problems_keys.dart';
import 'package:problemator/widgets/widgets.i18n.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:problemator/models/radarChart_data.dart';


import 'package:flutter/rendering.dart';


  /*
Widget _buildRadar(BuildContext context) {
  return CustomPaint(
    size: Size(double.infinity, double.infinity),
    painter: RadarChartPainter(),
  );
}

class RadarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(RadarChartPainter oldDelegate) {
    return false;
  }
} 

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2.0;
    var centerY = size.height / 2.0;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.8;

    var outlinePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0
    ..isAntiAlias = true;

    canvas.drawCircle(centerOffset, radius, outlinePaint);


    var ticks = [10, 20, 30];
    var tickDistance = radius / (ticks.length);
    const double tickLabelFontSize = 12;

    var tickPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..isAntiAlias = true;

    ticks.sublist(0, ticks.length - 1).asMap().forEach((index, tick) {
      var tickRadius = tickDistance * (index + 1);

      canvas.drawCircle(centerOffset, tickRadius, tickPaint);

      TextPainter(
        text: TextSpan(
          text: tick.toString(),
          style: TextStyle(color: Colors.grey, fontSize: tickLabelFontSize),
        ),
        textDirection: TextDirection.ltr,
      )
      ..layout(minWidth: 0, maxWidth: size.width)
      ..paint(
        canvas, Offset(centerX, centerY - tickRadius - tickLabelFontSize));
    });
  }
*/


class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDataBloc, DashboardDataState>(
      builder: (context, state) {
        if (state is DashboardDataLoading) {
          return LoadingIndicator(key: FlutterProblemsKeys.statsLoadingIndicator);
        } else if (state is DashboardDataLoaded) {
          final Dashboard dashboard = (state.dashboard);
          final ChartData chartData = state.runningChart;
          final RadarChartData radarChartData = state.runningRadar;
          return UserProfilePage(dashboard, chartData, radarChartData);
          
        } else if (state is DashboardDataNotLoaded) {
          return new Padding (
            padding : EdgeInsets.all(80.0),
            child : 
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
              Text("Dang, could not load profile. Try again?".i18n),
              RaisedButton(
                color : Colors.lightGreen,
                child : Text('Retry', style : TextStyle(color : Colors.white)),
                onPressed : () => {
                  BlocProvider.of<DashboardDataBloc>(context).add(LoadDashboardData())
                },
              ),
          ]));
        } else {
          return Container(key: FlutterProblemsKeys.emptyStatsContainer);
        }
      },
    );
  }



 }

 class UserProfilePage extends StatelessWidget {
   RadarChartData radarChartData;
   Dashboard dashboard;
   ChartData chartData;
   ChartDataPoint chartDataPoint;

  UserProfilePage(Dashboard _dash, ChartData _chart, RadarChartData _radar) {
    this.dashboard = _dash;
    this.chartData = _chart;
    this.radarChartData = _radar;
  }

   Widget _buildCoverImage(Size screenSize) {
     return Container(
       height: screenSize.height / 3.1,
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/images/mountain.jpg'),
            fit: BoxFit.cover,
           ),        
       ));
   }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tomi.jpg'),
              fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          )
        ),
      )
    );
  }

  Widget _buildFullName() {
     TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,

    );

    return Text(
      '${dashboard.etunimi}${dashboard.sukunimi}',
      
      style: _nameTextStyle
    );
  }
/*
  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300
        )
      ),
    );
  }*/

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w200
    );

    TextStyle _statCountTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold
    );

    return Column(
     mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
              Text(
                count, 
                style: _statCountTextStyle
              ),
              Text(
                label,
                style: _statLabelTextStyle
              )
            ],
            );
  }
  DateTime parseDate(String yearWeek) {
    String yearStr = yearWeek.substring(0,4);
    String weekStr = yearWeek.substring(6);
    int year = int.tryParse(yearStr);
    int week = int.tryParse(weekStr);

    DateTime parsedDate = new DateTime(year, 1, 1);
    parsedDate = parsedDate.add(new Duration(days: week * 7));
    return parsedDate;
  }
  
  Widget _buildMonthChart(BuildContext context) {

    List <DataPoint> convertedDataPoints = new List <DataPoint>();
    
    DataPoint point = null;
    for(ChartDataPoint srcPoint in chartData.dataPoints) {
      if(srcPoint.y != null) {
      point = new DataPoint<DateTime>(value: double.tryParse(srcPoint.a), xAxis: parseDate(srcPoint.y));
        convertedDataPoints.add(point);
      }
    }
    
    data: [DataPoint];
    final toDate = DateTime.now();
    final fromDate = DateTime(toDate.year, toDate.month - 5);


    return Container(
        color: Colors.black26,
        height: MediaQuery.of(context).size.height / 2.87,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.MONTHLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "${convertedDataPoints.last.value.toString()}",
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: convertedDataPoints,
            ),
          ],
          
          config: BezierChartConfig(
            bubbleIndicatorTitleStyle: TextStyle(color: Colors.black, fontSize: 20),
            bubbleIndicatorLabelStyle: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
            bubbleIndicatorValueStyle: TextStyle(fontSize: 20, color: Colors.black),
            snap: true,
            xAxisTextStyle: TextStyle(fontSize: 16),
            verticalIndicatorStrokeWidth: 3.9,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: true,
            backgroundColor: Colors.grey[800],
            footerHeight: 65.0
          ),
        ),
      );
  }
  Widget _buildLine(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0)
    );
  } 
/*
  Widget _buildButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: FloatingActionButton.extended(
        onPressed: () => print("Followed!"),
        backgroundColor: Colors.cyan[200],
        label: Text("FOLLOW"),
        
        ),
    
    );
  }
*/





  Widget _buildStatContainer() {

    return Container(
      height: 65.0,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.cyan[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Avarage Grade", '${dashboard.avgrade}'),
          _buildStatItem("Boulder Ticked", '${dashboard.ascents}'),
          _buildStatItem("Sport Ticked", '${dashboard.sportAscents}')
            ],
      ),
    );
    
  }
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  //_buildStatus(context),
                  _buildStatContainer(),
                  _buildMonthChart(context),
                  //_buildRadar(context)
                 // _buildLine(screenSize),
                  //_buildButton()
                ],
                ),
            ),
          )
        ],
      )
    );
  }

 }