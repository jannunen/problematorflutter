import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:problemator/core/core.dart';
import 'package:i18n_extension/i18n_widget.dart';


import 'api/repository_api.dart';
import 'blocs/blocs.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/stats/stats.dart';
import 'blocs/tab/tab.dart';
import 'screens/screens.dart';
import './main.i18n.dart';

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
      title: "Problemator".i18n,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('en', "US"),
          const Locale('fi', "FI"),
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
            child: I18n( 
              initialLocale: Locale("fi"),
              child: HomeScreen()),
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
