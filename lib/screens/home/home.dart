import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/widgets/drawer.dart';
import 'package:problemator/widgets/problems/add_problem.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    ProblemsRepository _problemsRepository = RepositoryProvider.of<ProblemsRepository>(context);
    _problemsRepository.setApiKey(user.jwt);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder(
            cubit: BlocProvider.of<HomeBloc>(context),
            builder: (context, state) {
              if (state is HomeLoading) {
                return CircularProgressIndicator();
              } else if (state is HomeLoaded) {
                return Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Climber's log",
                          style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.bold)),
                      Text(user.email, style: textTheme.headline6.copyWith(fontSize: 14)),
                      Text(user.name ?? '', style: textTheme.headline5),
                      const SizedBox(height: 4.0),
                      _buildTodayArea(context, state.dashboard),
                      _buildFloorMap(context, state.dashboard),
                      _buildMyLogs(context, state.dashboard),
                      //Avatar(photo: user.photo),
                    ],
                  ),
                );
              }
              return Container(child: Text("Unknown state" + state.toString()));
            }),
      ),
    );
  }

  Widget _buildTodayArea(BuildContext context, Dashboard dashboard) {
    int tickAmountToday = dashboard.ticksToday?.length ?? 0;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        children: [
          Text("Today"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    tickAmountToday.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(padding: EdgeInsets.all(1.0)),
                  Text("route(s)")
                ],
              ),
              RaisedButton(
                  onPressed: () => _openAddProblemDialog(context),
                  color: colorScheme.roundButtonBackground,
                  textColor: colorScheme.roundButtonTextColor,
                  padding: EdgeInsets.all(14.0),
                  child: Column(children: [
                    Icon(
                      Icons.add,
                      size: 25,
                    ),
                    Text("Add"),
                  ]),
                  shape: CircleBorder()),
            ],
          ),
        ],
      ),
    );
  }

  void _openAddProblemDialog(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (ctx) {
          // DO NOT name this parameter to context.
          // Then the correct context cannot be found and the bloc chain breaks.
          return BlocProvider<HomeBloc>.value(
              value: BlocProvider.of<HomeBloc>(context), child: AddProblemForm());
        });
  }

  Widget _buildFloorMap(BuildContext context, Dashboard dashboard) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
      color: colorScheme.gymFloorPlanBackroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(image: AssetImage('assets/images/floorplans/floorplan_1.png')),
      ),
    );
  }

  Widget _buildMyLogs(BuildContext context, Dashboard dashboard) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.myLogsContainerBackgroundColor,
        ),
        child: Column(
          children: [
            SizedBox(height: 8.0),
            Text("My logs",
                style: textTheme.headline5.copyWith(color: colorScheme.myLogsHeaderTextColor)),
            // Go for left column having the big number icons and the
            // right side for the bar chart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: _buildMyLogsLeftColumn(context)),
                Expanded(flex: 2, child: _buildMyLogsRightColumn(context)),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildMyLogsLeftColumn(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        child: Column(
      children: [
        Text("9", style: textTheme.headline1.copyWith(fontWeight: FontWeight.normal)),
        Text("sessions"),
        Text("37", style: textTheme.headline1.copyWith(fontWeight: FontWeight.normal)),
        Text("routes"),
      ],
    ));
  }

  Widget _buildMyLogsRightColumn(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text("barchart here"),
        Text("Last 30 days - Boulder"),
      ],
    ));
  }
}
