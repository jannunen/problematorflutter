import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/blocs/blocs.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/screens/screens.dart';
import 'package:problemator/flutter_todos_keys.dart';

class FilteredProblems extends StatelessWidget {
  FilteredProblems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder<FilteredProblemsBloc, FilteredProblemsState>(
      builder: (context, state) {
        if (state is FilteredProblemsLoading) {
          return LoadingIndicator(key: ArchSampleKeys.problemsLoading);
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
        } else {
          return Container(key: FlutterProblemsKeys.filteredProblemsEmptyContainer);
        }
      },
    );
  }
}
