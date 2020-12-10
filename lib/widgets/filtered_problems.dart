import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_bloc.dart';
import 'package:problemator/blocs/filtered_problems/filtered_problems_state.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/blocs/blocs.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/flutter_problems_keys.dart';

class FilteredProblems extends StatelessWidget {
  FilteredProblems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(
      builder: (context, state) {
        if (state is FilteredProblemsLoading) {
          return LoadingIndicator(
            key: ArchSampleKeys.problemsLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Loading problems..."),
            ),
          );
        } else if (state is FilteredProblemsLoaded) {
          final problems = state.filteredProblems;
          return ListView.builder(
            key: ArchSampleKeys.problemList,
            itemCount: problems.length,
            itemBuilder: (BuildContext context, int index) {
              final problem = problems[index];
              return ProblemItem(
                problem: problem,
                onDismissed: (direction) {
                  /*
                  BlocProvider.of<ProblemsBloc>(context).add(DeleteProblem(problem));
                  Scaffold.of(context).showSnackBar(DeleteProblemSnackBar(
                    key: ArchSampleKeys.snackbar,
                    problem: problem,
                    onUndo: () =>
                        BlocProvider.of<ProblemsBloc>(context).add(AddProblem(problem)),
                    localizations: localizations,
                  ));
                  */
                },
                onTap: () async {
                  /*
                  final removedProblem = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return DetailsScreen(id: problem.id);
                    }),
                  );
                  if (removedProblem != null) {
                    Scaffold.of(context).showSnackBar(DeleteProblemSnackBar(
                      key: ArchSampleKeys.snackbar,
                      problem: problem,
                      onUndo: () => BlocProvider.of<ProblemsBloc>(context)
                          .add(AddProblem(problem)),
                      localizations: localizations,
                    ));
                  }
                  */
                },
                onCheckboxChanged: (_) {
                  /*
                  BlocProvider.of<ProblemsBloc>(context).add(
                    UpdateProblem(problem.copyWith(complete: !problem.complete)),
                  );
                  */
                },
              );
            },
          );
        } else if (state is ProblemsErrorLoading) {
          return Container(child: Text("Error Loading problems, probably login outdated"));
        } else {
          return Container(key: FlutterProblemsKeys.filteredProblemsEmptyContainer);
        }
      },
    );
  }
}
