import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/dashboard_data/dashboard_data.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/blocs/stats/stats.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/flutter_problems_keys.dart';
import 'package:problemator/widgets/widgets.i18n.dart';

class Profile extends StatelessWidget {
  Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardDataBloc, DashboardDataState>(
      builder: (context, state) {
        if (state is DashboardDataLoading) {
          return LoadingIndicator(key: FlutterProblemsKeys.statsLoadingIndicator);
        } else if (state is DashboardDataLoaded) {
          final Dashboard dashboard= state.dashboard;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    dashboard.toString(),
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
          );
        } else if (state is DashboardDataNotLoaded) {
          return new Padding (
            padding : EdgeInsets.all(16.0),
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
