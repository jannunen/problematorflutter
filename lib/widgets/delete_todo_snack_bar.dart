import 'package:flutter/material.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteTodoSnackBar({
    Key key,
    @required Problem problem,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.problemDeleted(problem.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
