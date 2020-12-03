import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/widgets/drawer.dart';
import 'package:problemator/widgets/image_map.dart';
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
                return Column(
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
    List<ImageMapShape> shapes = [
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall A", points: [
        ImageMapCoordinate(48.14, 78.91),
        ImageMapCoordinate(47.36, 64.19),
        ImageMapCoordinate(38.28, 65.36),
        ImageMapCoordinate(38.67, 78.91),
      ]),
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall B", points: [
        ImageMapCoordinate(11.43, 79.04),
        ImageMapCoordinate(21.19, 65.49),
        ImageMapCoordinate(37.5, 64.97),
        ImageMapCoordinate(37.11, 79.17),
      ]),
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall C", points: [
        ImageMapCoordinate(10.55, 78.91),
        ImageMapCoordinate(10.55, 54.56),
        ImageMapCoordinate(19.63, 54.56),
        ImageMapCoordinate(20.9, 64.71),
      ]),
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall C", points: [
        ImageMapCoordinate(11.04, 37.89),
        ImageMapCoordinate(11.33, 24.22),
        ImageMapCoordinate(41.02, 24.74),
        ImageMapCoordinate(36.52, 37.63),
      ]),
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall C", points: [
        ImageMapCoordinate(41.15, 24.74),
        ImageMapCoordinate(42.19, 33.46),
        ImageMapCoordinate(46, 37.89),
        ImageMapCoordinate(54.88, 40.63),
        ImageMapCoordinate(61.13, 37.76),
        ImageMapCoordinate(62.6, 31.38),
        ImageMapCoordinate(62.11, 23.96),
      ]),
    ];

    return Container(
      color: colorScheme.gymFloorPlanBackroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageMap(shapes),
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
                Expanded(child: _buildMyLogsLeftColumn(context)),
                Expanded(child: _buildMyLogsRightColumn(context)),
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
