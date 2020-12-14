import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:problemator/api/repository_api.dart';
import 'package:problemator/blocs/authentication/authentication_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/widgets/drawer.dart';
import 'package:problemator/widgets/image_map.dart';
import 'package:problemator/widgets/imagemap/image_map_coordinate.dart';
import 'package:problemator/widgets/imagemap/image_map_shape.dart';
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
                  Expanded(child: _buildProblemList(context, state, user)),
                  //Avatar(photo: user.photo),
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

    return Container(
      color: colorScheme.gymFloorPlanBackroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageMap(shapes),
      ),
    );
  }

  Widget _buildProblemList(
      BuildContext context, FilteredProblemsState filteredProblemsState, User user) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(builder: (context, state) {
      if (state.status == FilteredProblemsStatus.loaded && state.filteredProblems.length > 0) {
        return GroupedListView<Problem, String>(
          elements: state.filteredProblems,
          groupBy: (element) => element.wallchar,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              int.tryParse(item1.problemid).compareTo(int.tryParse(item2.problemid)),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          groupHeaderBuilder: (Problem problem) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              problem.wallchar + " " + problem.walldesc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          indexedItemBuilder: (context, problem, index) {
            if (index == 0) {
              return Column(children: [
                Text("Climber's log",
                    style: theme.textTheme.headline5.copyWith(fontWeight: FontWeight.bold)),
                Text(user.email, style: textTheme.headline6.copyWith(fontSize: 14)),
                Text(user.name ?? '', style: textTheme.headline5),
                const SizedBox(height: 4.0),
                _buildFloorMap(context),
                _buildProblemTile(context, problem),
              ]);
            } else {
              return _buildProblemTile(context, problem);
            }
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
