import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/flutter_todos_keys.dart';
import 'package:problemator/models/models.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key key}) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProblemsBloc, ProblemsState>(
      builder: (context, state) {
        if (state is ProblemsLoaded) {
          bool allComplete =
              (BlocProvider.of<ProblemsBloc>(context).state as ProblemsLoaded)
                  .problems
                  .every((problem) => problem.ticked!=null);
          return PopupMenuButton<ExtraAction>(
            key: FlutterProblemsKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<ProblemsBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<ProblemsBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? ArchSampleLocalizations.of(context).markAllIncomplete
                      : ArchSampleLocalizations.of(context).markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  ArchSampleLocalizations.of(context).clearCompleted,
                ),
              ),
            ],
          );
        }
        return Container(key: FlutterProblemsKeys.extraActionsEmptyContainer);
      },
    );
  }
}
