import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_event.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/blocs/problems/problems_bloc.dart';
import 'package:problemator/blocs/problems/problems_state.dart';
import 'package:problemator/models/gym.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/models/route_sort_options.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/widgets/drawer.dart';
import 'package:problemator/widgets/image_map.dart';
import 'package:problemator/widgets/imagemap/image_map_coordinate.dart';
import 'package:problemator/widgets/imagemap/image_map_shape.dart';
import 'package:problemator/widgets/problemator_button.dart';
import 'package:problemator/widgets/problemator_round_button.dart';
import 'package:problemator/widgets/problems/problem_color_indicator.dart';
import 'package:problemator/widgets/problems/show_problem.dart';

// This needs to be a statefulwidget, because we want to save
// the UI state for the ExpansionTile

class GymPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GymPage();
}

class _GymPage extends State<GymPage> {
  final Key gradesExpansionTileState = PageStorageKey('gradesExpansionTile');
  final Key styleExpansionTileState = PageStorageKey('styleExpansionTile');
  final Key sortExpansionTileState = PageStorageKey('sortExpansionTile');
  final Key filtersExpansionTileState = PageStorageKey('filtersExpansionTile');

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GymPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final Gym gym = context.select((HomeBloc bloc) => bloc.state.dashboard.gym);

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
      body: BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(
          cubit: BlocProvider.of<FilteredProblemsBloc>(context),
          builder: (context, state) {
            if (state.status == FilteredProblemsStatus.loading) {
              return CircularProgressIndicator();
            } else if (state.status == FilteredProblemsStatus.loaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: _buildGymPage(context, state, user, gym)),
                ],
              );
            }
            return Container(child: Text("Unknown state" + state.toString()));
          }),
    );
  }

  Widget _buildFloorMap(BuildContext context, Gym gym) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return ExpansionTile(
        title: Text("Floor plan / Sectors"),
        trailing: Text("Click to expand"),
        children: [
          Container(
            color: colorScheme.gymFloorPlanBackroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageMap(
                image: Image.network(gym.floorPlanURL),
                shapes: gym.shapes,
                onTap: (event) {
                  BlocProvider.of<FilteredProblemsBloc>(context)
                      .add(UpdateFilter(selectedWalls: event));
                },
              ),
            ),
          ),
        ]);
  }

  Widget _buildGymPage(
      BuildContext context, FilteredProblemsState filteredProblemsState, User user, Gym gym) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    final List<Problem> allProblems =
        context.select((ProblemsBloc bloc) => (bloc.state as ProblemsLoaded).problems);

    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(builder: (context, state) {
      if (state.status == FilteredProblemsStatus.loaded) {
        final List<Problem> problems =
            (state.filteredProblems != null && state.filteredProblems.length > 0)
                ? state.filteredProblems
                : ([Problem(wallchar: '', walldesc: '', problemid: 'null')].toList());
        return GroupedListView<Problem, String>(
          elements: problems,
          groupBy: (element) => element.wallchar,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          /*
          itemComparator: (item1, item2) =>
              int.tryParse(item1.problemid).compareTo(int.tryParse(item2.problemid)),
              */
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: false,
          groupHeaderBuilder: (Problem problem) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              problem.wallchar + " " + problem.walldesc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          indexedItemBuilder: (context, problem, index) {
            return Builder(
              builder: (context) {
                if (index == 0) {
                  return Column(children: [
                    const SizedBox(height: 4.0),
                    _buildRouteFilters(context, state),
                    _buildCompletionStatus(context, state),
                    _buildFloorMap(context, gym),
                    _buildFilters(context, state),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Problem list", style: theme.textTheme.headline1),
                        (state.filteredProblems.length == allProblems.length)
                            ? Text(allProblems.length.toString() + "route(s) in total")
                            : Text(
                                "Showing " +
                                    state.filteredProblems.length.toString() +
                                    "/" +
                                    allProblems.length.toString(),
                                style: theme.textTheme.headline4)
                      ],
                    ),
                    _buildProblemTile(context, problem),
                  ]);
                } else {
                  return _buildProblemTile(context, problem);
                }
              },
            );
          },
        );
      } else if (state.status == FilteredProblemsStatus.loading) {
        return Container(padding: new EdgeInsets.all(17), child: Text("Loading problems"));
      }
    });
  }

  Widget _buildProblemTile(BuildContext context, Problem problem) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    if (problem.problemid == 'null') {
      return Container(child: Text("No problems matching the filters."));
    }
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (dialogContext) {
                return MultiBlocProvider(providers: [
                  BlocProvider<FilteredProblemsBloc>.value(
                      value: BlocProvider.of<FilteredProblemsBloc>(context)),
                  BlocProvider<ProblemBloc>.value(value: BlocProvider.of<ProblemBloc>(context)),
                  BlocProvider<HomeBloc>.value(value: BlocProvider.of<HomeBloc>(context)),
                ], child: ShowProblem(id: problem.id));
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

  Widget _buildFilters(BuildContext context, FilteredProblemsState state) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return ExpansionTile(
      key: filtersExpansionTileState,
      title: Text("Filters"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildGradeFilterOptions(context, state),
              _buildProblemStyleOptions(context, state),
              _buildSortOptionsContainer(context, state),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildSortOptions(BuildContext context, RouteSortOption selectedSort) {
    return RouteFilteringOptions.sortOptions.entries
        .map((entry) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: ProblematorButton(
                child: Text(entry.value),
                selected: entry.key == selectedSort,
                onPressed: () => _handleSortOptionClick(context, entry.key),
              ),
            ))
        .toList();
  }

  void _handleSortOptionClick(BuildContext context, RouteSortOption sort) {
    print("Sort by" + sort.toString());
    BlocProvider.of<FilteredProblemsBloc>(context).add(UpdateFilter(sort: sort));
  }

  Widget _buildProblemStyleOptions(BuildContext context, state) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SingleChildScrollView(
      key: styleExpansionTileState,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text("Style", style: theme.textTheme.headline2),
          SizedBox(width: 4),
          ..._buildProblemStyles(context, state.selectedRouteAttributes),
        ],
      ),
    );
  }

  Widget _buildSortOptionsContainer(BuildContext context, state) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return SingleChildScrollView(
      key:
          sortExpansionTileState, // This needs to be given, because parent expansiontile has it also

      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text("Sort by", style: theme.textTheme.headline2),
          SizedBox(width: 4),
          ..._buildSortOptions(context, state.sort),
        ],
      ),
    );
  }

  List<Widget> buildGradeFilterOptionRows(BuildContext context, selectedGradeFilters) {
    return RouteFilteringOptions.gradeFilterOptions.entries
        .map((entry) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: ProblematorButton(
                child: Text(entry.key),
                selected: selectedGradeFilters.contains(entry.value),
                onPressed: () => _handleGradeFilterOptionClick(context, entry.value),
              ),
            ))
        .toList();
  }

  Widget _buildGradeFilterOptions(BuildContext context, FilteredProblemsState state) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      key: gradesExpansionTileState,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text("Grades", style: theme.textTheme.headline2),
          ...buildGradeFilterOptionRows(context, state.gradeFilters),
        ],
      ),
    );
  }

  List<Widget> _buildProblemStyles(BuildContext context, List<String> selectedRouteAttributes) {
    final List<String> attributesInUse =
        context.select((ProblemsBloc bloc) => (bloc.state as ProblemsLoaded).attributesInUse);

    return attributesInUse
        .map((e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: ProblematorButton(
                  selected: selectedRouteAttributes.contains(e),
                  onPressed: () {
                    BlocProvider.of<FilteredProblemsBloc>(context)
                        .add(UpdateFilter(selectedRouteAttributes: [e]));
                  },
                  child: Text(e)),
            ))
        .toList();
  }

  Widget _buildCompletionStatus(BuildContext context, FilteredProblemsState state) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    final List<Problem> allProblems =
        context.select((ProblemsBloc bloc) => (bloc.state as ProblemsLoaded).problems);
    final List<Problem> tickedProblems = allProblems.where((element) => element.ticked).toList();
    final double completionPercentage =
        ((tickedProblems.length / allProblems.length) * 100).round() / 100;
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ProblematorRoundButton(
                      padding: EdgeInsets.only(top: 7),
                      backgroundColor: Colors.white,
                      child: Text(tickedProblems.length.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ))),
                  Text("Your ticks")
                ],
              ),
              Column(
                children: [
                  ProblematorRoundButton(
                      padding: EdgeInsets.only(top: 7),
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        child: Text(allProblems.length.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                      )),
                  Text("Total problems")
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: completionPercentage,
                  animateFromLastPercent: true,
                  center: Text((completionPercentage * 100).round().toString() + "%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Color.fromRGBO(108, 197, 81, 1)),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildRouteFilters(BuildContext context, FilteredProblemsState state) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ProblematorButton(
              child: Text("All routes"),
              selected: state.activeFilter == VisibilityFilter.all,
              onPressed: () {
                // Update filter
                BlocProvider.of<FilteredProblemsBloc>(context)
                    .add(UpdateFilter(filter: VisibilityFilter.all));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ProblematorButton(
              child: Text("New routes"),
              selected: state.activeFilter == VisibilityFilter.fresh,
              onPressed: () {
                // Update filter
                BlocProvider.of<FilteredProblemsBloc>(context)
                    .add(UpdateFilter(filter: VisibilityFilter.fresh));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ProblematorButton(
              child: Text("Expiring routes"),
              selected: state.activeFilter == VisibilityFilter.expiring,
              onPressed: () {
                // Update filter
                BlocProvider.of<FilteredProblemsBloc>(context)
                    .add(UpdateFilter(filter: VisibilityFilter.expiring));
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: ProblematorButton(
              child: Text("Circuits"),
              selected: state.activeFilter == VisibilityFilter.circuits,
              onPressed: () {
                // Update filter
                BlocProvider.of<FilteredProblemsBloc>(context)
                    .add(UpdateFilter(filter: VisibilityFilter.circuits));
              }),
        ),
      ],
    );
  }

  Widget _buildTileTrailing(BuildContext context, Problem problem) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(problem.addedrelative ?? "No data"),
        Text((problem.ascentcount ?? "No ascents") + " ascent(s)"),
      ],
    );
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

  Widget _buildTileMain(BuildContext context, Problem problem) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(width: 50, child: Text(problem.gradename, style: textTheme.headline1)),
      _buildProblemLikes(context, problem),
    ]);
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
}

_handleGradeFilterOptionClick(BuildContext context, GradeSortScoreSpan gradeFilter) {
  print("Filter by grade" + gradeFilter.toString());
  BlocProvider.of<FilteredProblemsBloc>(context).add(UpdateFilter(gradeFilters: [gradeFilter]));
}
