import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/models/models.dart';

class ProblemItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Problem problem;

  ProblemItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.problem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.problemItem(problem.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          key: ArchSampleKeys.problemItemCheckbox(problem.id),
          value: problem.ticked != null,
          onChanged: onCheckboxChanged,
        ),
        title: Hero(
          tag: '${problem.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              problem.tag,
              key: ArchSampleKeys.problemItemTask(problem.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: problem.tag.isNotEmpty
            ? Text(
                problem.tag,
                key: ArchSampleKeys.problemItemNote(problem.id),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              )
            : null,
      ),
    );
  }
}
