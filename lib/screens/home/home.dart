import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/gyms/bloc/gyms_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/screens/choose_gym.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/widgets/drawer.dart';
import 'package:problemator/widgets/floor_map.dart';
import 'package:problemator/widgets/problemator_button.dart';
import 'package:problemator/widgets/problems/add_problem.dart';
import 'package:problemator/widgets/problems/problem_color_indicator.dart';
import 'package:problemator/widgets/problems/show_problem.dart';

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
      body: BlocBuilder(
          cubit: BlocProvider.of<HomeBloc>(context),
          builder: (context, state) {
            if (state is HomeLoading) {
              return CircularProgressIndicator();
            } else if (state is HomeLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: _buildMainViewAsList(context, state, user)),
                ],
              );
            }
            return Container(child: Text("Unknown state" + state.toString()));
          }),
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

  Widget _buildMainViewAsList(BuildContext context, HomeState homeState, User user) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(builder: (context, state) {
      if (state.status == FilteredProblemsStatus.loaded) {
        return ListView(
          children: [
            Text("Climber's log",
                style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.bold)),
            Text(user.email, style: textTheme.headline6.copyWith(fontSize: 14)),
            Text(user.name ?? '', style: textTheme.headline5),
            Row(
              children: [
                Text("Current gym: "),
                RaisedButton(
                  child: Text(user.gym != null ? user.gym.name : "Not selected, click to select"),
                  onPressed: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (dialogContext) {
                        return Scaffold(
                            body: BlocProvider<GymsBloc>.value(
                                value: BlocProvider.of<GymsBloc>(context), child: ChooseGym()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            _buildTodayArea(context, homeState.dashboard),
            FloorMap(dashboard: homeState.dashboard),
          ],
        );
      } else if (state.status == FilteredProblemsStatus.loading) {
        return Container(padding: new EdgeInsets.all(17), child: Text("Loading problems"));
      } else if (state.status == FilteredProblemsStatus.error) {
        return Container(
            padding: new EdgeInsets.all(17),
            child: Column(
              children: [
                Text("Error loading problems: " + state.error),
                ProblematorButton(
                    child: Text(
                      "Login again",
                    ),
                    onPressed: () {
                      context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                    })
              ],
            ));
      } else {
        return Text("Weird state " + state.toString());
      }
    });
  }

  Widget _buildProblemTile(BuildContext context, Problem problem) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (dialogContext) {
                return BlocProvider.value(
                    value: BlocProvider.of<HomeBloc>(context), child: ShowProblem(id: problem.id));
              }),
            );
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: _buildTileLeading(context, problem),
          title: _buildTileMain(context, problem),
          trailing: _buildTileTrailing(context, problem),
        ),
      ),
    );
  }

  _showChooseGymDialog(BuildContext context, AuthenticationState state) {
    return Container(
      child: Column(children: [
        Text("Please select a gym before you continue"),
      ]),
    );
  }
}

Widget _buildTileTrailing(BuildContext context, Problem problem) {
  return Text(problem.addedrelative ?? "No data");
}

_buildTileMain(BuildContext context, Problem problem) {
  final textTheme = Theme.of(context).textTheme;
  ThemeData theme = Theme.of(context);
  ColorScheme colorScheme = theme.colorScheme;
  return Row(mainAxisSize: MainAxisSize.min, children: [
    SizedBox(width: 50, child: Text(problem.gradename, style: textTheme.headline1)),
    _buildProblemLikes(context, problem),
  ]);
}

Widget _buildProblemLikes(BuildContext context, Problem problem) {
  final textTheme = Theme.of(context).textTheme;
  ThemeData theme = Theme.of(context);
  ColorScheme colorScheme = theme.colorScheme;
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Row(
      children: [
        Icon(Icons.favorite, size: 16, color: Colors.red[400]),
        SizedBox(width: 4),
        Text(problem.cLike.toString(), style: textTheme.headline3),
      ],
    ),
  );
}

Widget _buildTileLeading(BuildContext context, Problem problem) {
  final textTheme = Theme.of(context).textTheme;
  ThemeData theme = Theme.of(context);
  ColorScheme colorScheme = theme.colorScheme;
  return Row(mainAxisSize: MainAxisSize.min, children: [
    ProblemColorIndicator(htmlcolour: problem.htmlcolour, width: 24, height: 24),
    SizedBox(width: 4),
    Text(problem.tagshort ?? "No colour", style: textTheme.headline2)
  ]);
}
