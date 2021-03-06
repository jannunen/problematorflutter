import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_event.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/models/models.dart';
import 'package:problemator/screens/gym/gym.dart';
import 'package:problemator/widgets/image_map.dart';

class FloorMap extends StatelessWidget {
  final Dashboard dashboard;

  FloorMap({this.dashboard});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    Image image;
    if (this.dashboard.gym != null &&
        dashboard.gym.floorPlanExists != null &&
        dashboard.gym.floorPlanExists) {
      image = Image.network(this.dashboard.gym.floorPlanURL);
    }
    if (this.dashboard.gym.id == null) {
      return Container(
          child: Column(
        children: [
          SizedBox(height: 20),
          Center(child: Text("Gym not selected")),
        ],
      ));
    }
    if (this.dashboard.gym == null) {
      return Container(
          child: Column(
        children: [
          SizedBox(height: 20),
          Center(child: Text("Loading floor map...")),
        ],
      ));
    }
    return Container(
      color: colorScheme.gymFloorPlanBackroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ImageMap(
            image: image,
            shapes: this.dashboard.gym.shapes,
            onTap: (event) {
              print("Selected wall(s): " + event.toString());
              BlocProvider.of<FilteredProblemsBloc>(context)
                  .add(UpdateFilter(selectedWalls: event));

              // Navigate to  gym view.
              Navigator.of(context).push(
                MaterialPageRoute(builder: (dialogContext) {
                  return MultiBlocProvider(providers: [
                    BlocProvider<FilteredProblemsBloc>.value(
                        value: BlocProvider.of<FilteredProblemsBloc>(context)),
                    BlocProvider<ProblemBloc>.value(value: BlocProvider.of<ProblemBloc>(context)),
                    BlocProvider<HomeBloc>.value(value: BlocProvider.of<HomeBloc>(context)),
                  ], child: GymPage());
                }),
              );
            }),
      ),
    );
  }
}
