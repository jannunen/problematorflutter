import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/dashboard_data/dashboard_data.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/repository/dashboard_entity.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/flutter_problems_keys.dart';
import 'package:problemator/widgets/widgets.i18n.dart';

import 'package:flutter/rendering.dart';


class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDataBloc, DashboardDataState>(
      builder: (context, state) {
        if (state is DashboardDataLoading) {
          return LoadingIndicator(key: FlutterProblemsKeys.statsLoadingIndicator);
        } else if (state is DashboardDataLoaded) {
          final Dashboard dashboard = (state.dashboard);
          return UserProfilePage(dashboard);
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

/*
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Profile", 
      debugShowCheckedModeBanner: false,
      home: UserProfilePage()
      );
  }
  */

 }

 class UserProfilePage extends StatelessWidget {

   
   //final String _status = "";
   //final String _story = 'Today Ticked Boulders: ${dashboard.boulderToday}';
   //final String _avgGrade = "";
   //final String _followers = "150";
   //final String _problemsTicked = "";
   Dashboard dashboard;
   //final String _fullName = "";

  UserProfilePage(Dashboard _dash) {
    this.dashboard = _dash;
    
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

  Widget _buildStory(BuildContext context) {
    TextStyle _storyStyle = TextStyle(
      fontSize: 18.0,
      fontStyle: FontStyle.italic,
      color: Colors.black87,
      fontWeight: FontWeight.w500
    );

    return Container(
      //color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(15.0),
      child: Text(
      'Today Ticked Boulders: ${dashboard.boulderToday} \n'
      'This Month Ticked Boulders: ${dashboard.boulderMonth} \n'
      'Today Ticked Sport: ${dashboard.sportToday} \n'
      'This Month Ticked Sport: ${dashboard.sportMonth}',
      style: _storyStyle,
      textAlign: TextAlign.center,
      
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


  Widget _buildStatContainer() {

    return Container(
      height: 65.0,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Color(0XFFEFF4F7),
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
      backgroundColor: Colors.white10,
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
                  _buildStory(context),
                  _buildLine(screenSize),
                  _buildButton()
                ],
                ),
            ),
          )
        ],
      )
    );
  }

 }