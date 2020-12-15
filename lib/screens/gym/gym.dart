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

class GymPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GymPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    ProblemsRepository _problemsRepository = RepositoryProvider.of<ProblemsRepository>(context);
    _problemsRepository.setApiKey(user.jwt);
    // TODO: FIX
    _problemsRepository.setGym("1");
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
                  Expanded(child: _buildGymPage(context, state, user)),
                ],
              );
            }
            return Container(child: Text("Unknown state" + state.toString()));
          }),
    );
  }

  Widget _buildFloorMap(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    List<ImageMapShape> shapes = [
      ImageMapShape(description: 'Wall A has diipadaapa', title: "Wall A", id: 30, points: [
        ImageMapCoordinate(48.14, 78.91),
        ImageMapCoordinate(47.36, 64.19),
        ImageMapCoordinate(38.28, 65.36),
        ImageMapCoordinate(38.67, 78.91),
      ]),
      ImageMapShape(description: 'Wall B has diipadaapa', title: "Wall B", id: 709, points: [
        ImageMapCoordinate(11.43, 79.04),
        ImageMapCoordinate(21.19, 65.49),
        ImageMapCoordinate(37.5, 64.97),
        ImageMapCoordinate(37.11, 79.17),
      ]),
      ImageMapShape(description: 'Wall C has diipadaapa', title: "Wall C", id: 710, points: [
        ImageMapCoordinate(10.55, 78.91),
        ImageMapCoordinate(10.55, 54.56),
        ImageMapCoordinate(19.63, 54.56),
        ImageMapCoordinate(20.9, 64.71),
      ]),
      ImageMapShape(description: 'Wall D has diipadaapa', title: "Wall D", id: 33, points: [
        ImageMapCoordinate(11.04, 37.89),
        ImageMapCoordinate(11.33, 24.22),
        ImageMapCoordinate(41.02, 24.74),
        ImageMapCoordinate(36.52, 37.63),
      ]),
      ImageMapShape(description: 'Wall E has diipadaapa', title: "Wall E", id: 34, points: [
        ImageMapCoordinate(41.15, 24.74),
        ImageMapCoordinate(42.19, 33.46),
        ImageMapCoordinate(46, 37.89),
        ImageMapCoordinate(54.88, 40.63),
        ImageMapCoordinate(61.13, 37.76),
        ImageMapCoordinate(62.6, 31.38),
        ImageMapCoordinate(62.11, 23.96),
      ]),
    ];

    return ExpansionTile(
        title: Text("Floor plan / Sectors"),
        trailing: Text("Click to expand"),
        children: [
          Container(
            color: colorScheme.gymFloorPlanBackroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageMap(
                shapes,
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
      BuildContext context, FilteredProblemsState filteredProblemsState, User user) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

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
                    _buildFloorMap(context),
                    _buildFilters(context, state),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Problem list", style: theme.textTheme.headline1),
                        Text(state.filteredProblems.length.toString() + " route(s)",
                            style: theme.textTheme.headline2),
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
      title: Text("Filters"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Grades", style: theme.textTheme.headline2),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("Up to 4+")),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("Up to 5")),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("5 to 5+")),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("6a to 6c")),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("7a to 7c")),
                    SizedBox(width: 4),
                    ProblematorButton(child: Text("7c+ and higher")),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Style", style: theme.textTheme.headline2),
                    SizedBox(width: 4),
                    ..._buildProblemStyles(context, state.selectedRouteAttributes),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Sort by", style: theme.textTheme.headline2),
                    SizedBox(width: 4),
                    ..._buildSortOptions(context, state.sort)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildSortOptions(BuildContext context, RouteSortOption selectedSort) {
    Map<RouteSortOption, String> sortOptions = {
      RouteSortOption.newest_first: "Newest first",
      RouteSortOption.newest_last: "Newest last",
      RouteSortOption.most_ascents: "Most ascents",
      RouteSortOption.least_ascents: "Least ascents",
      RouteSortOption.hardest_first: "Hardest first",
      RouteSortOption.hardest_last: "Hardest last",
      RouteSortOption.most_liked: "Most liked",
      RouteSortOption.least_liked: "Least liked",
      RouteSortOption.routesetter: "Routesetter",
      RouteSortOption.tag_asc: "Tag ASC",
      RouteSortOption.tag_desc: "Tag DESC",
      RouteSortOption.sectors_asc: "Sectors ASC",
      RouteSortOption.sectors_desc: "Sectors DESC",
    };
    return sortOptions.entries
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

  _handleSortOptionClick(BuildContext context, RouteSortOption sort) {
    print("Sort by" + sort.toString());
    BlocProvider.of<FilteredProblemsBloc>(context).add(UpdateFilter(sort: sort));
  }
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
