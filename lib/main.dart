import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:problemator/components/ImageMap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:i18n_extension/i18n_widget.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:problemator/components/FancyFab.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/localization.dart';

import 'api/repository_api.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/stats/stats.dart';
import 'blocs/tab/tab.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    BlocProvider(
      create: (context) {
        return ProblemsBloc(
          problemsRepository: ProblemsRepositoryFlutter(),
        )..add(LoadProblems());
      },
      child: Problemator(),
    ),
  );
}

class Problemator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredProblemsBloc>(
                create: (context) => FilteredProblemsBloc(
                  problemsBloc: BlocProvider.of<ProblemsBloc>(context),
                ),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(
                  problemsBloc: BlocProvider.of<ProblemsBloc>(context),
                ),
              ),
            ],
            child: HomeScreen(),
          );
        },
          /*
        ArchSampleRoutes.addProblem: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addProblemScreen,
            onSave: (task, note) {
              BlocProvider.of<ProblemsBloc>(context).add(
                AddProblem(Problem(task, note: note)),
              );
            },
            isEditing: false,
          );
        },
          */
      },
    );
  }
}
