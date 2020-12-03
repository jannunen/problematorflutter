import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/home/bloc/home_bloc.dart';
import 'package:problemator/blocs/problem/bloc/problem_bloc.dart';
import 'package:problemator/blocs/problem/problem_bloc.dart';
import 'package:problemator/core/screen_helpers.dart';
import 'package:problemator/models/problem.dart';
import 'package:problemator/widgets/problems/bottom_sheet_add_tick.dart';
import 'package:problemator/widgets/problems/problem_color_indicator.dart';
import 'package:problemator/ui/theme/problemator_theme.dart';

class ShowProblem extends StatefulWidget {
  final String id;
  ShowProblem({this.id});
  @override
  State<StatefulWidget> createState() => _ShowProblem(id: id);
}

class _ShowProblem extends State<ShowProblem> {
  final String id;
  Problem problem;
  _ShowProblem({this.id});
  @override
  void initState() {
    // Call for additional info for the problem.
    context.read<ProblemBloc>().add(LoadProblemExtraInfo(id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Find problems

    this.problem = context.select(
        (HomeBloc b) => b.state.dashboard.problems.firstWhere((element) => element.id == id));
    // Find the problem from bloc and sta
    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(problem),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Row(
              children: [
                _buildProblemLeftPane(),
                _buildProblemRightPane(),
              ],
            ),
            _buildBottomSheet(context),
          ],
        ),
      ),
    );
  }

  Text _buildTitle(Problem problem) => Text('Route ' + problem.tagshort);

  Widget _buildProblemLeftPane() {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Container(
      height: displayHeight(context) * 0.4,
      width: displayWidth(context) * 0.3,
      decoration: BoxDecoration(
          color: colorScheme.leftPaneBackground,
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 20),
        child: Column(
          children: [
            Text(problem.gradename,
                style: textTheme.headline2.copyWith(fontSize: 40, fontWeight: FontWeight.normal)),
            ProblemColorIndicator(
              height: 30,
              width: 30,
              htmlcolour: problem.htmlcolour,
            ),
            SizedBox(
              height: 16,
            ),
            _buildProblemAttributes(problem.attributes),
            SizedBox(
              height: 12,
            ),
            Text((problem.ascentcount ?? "0") + " ascents",
                style: TextStyle(color: colorScheme.accentColor, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text((problem.cLike.toString() ?? "0") + " likes",
                style: TextStyle(color: colorScheme.accentColor)),
            SizedBox(
              height: 4,
            ),
            _buildDoLikeAction(context)
          ],
        ),
      ),
    );
  }

  Widget _buildProblemAttributes(List<dynamic> attributes) {
    return Flexible(child: Text(attributes.join("\n")));
  }

  Widget _buildDoLikeAction(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        child: Row(children: [
      Icon(
        Icons.favorite,
        color: colorScheme.accentColor,
      ),
      SizedBox(
        width: 4,
      ),
      Text("Like", style: TextStyle(color: colorScheme.accentColor, fontWeight: FontWeight.bold)),
    ]));
  }

  Widget _buildProblemRightPane() {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
      height: displayHeight(context) * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Route author"),
            Row(
              children: [
                Row(
                  children: [
                    Text(problem.author ?? "No author", style: colorScheme.problematorAccentStyle),
                    SizedBox(
                      width: 20,
                    ),
                    Text(problem.addedformatted ?? "N/A")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Text("Notes", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(problem.addt ?? "No additional info"),
              ],
            ),
            Text("+ add video beta"),
            Text("Opinions"),
            Text("7A+ jne"),
            SizedBox(
              height: 10,
            ),
            Text(problem.cDislike.toString() ?? "0" + "dislikes"),
            _buildDislikeAction(context)
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return BlocBuilder<ProblemBloc, ProblemState>(builder: (context, state) {
      if (state is ProblemExtraInfoLoaded) {
        return BottomSheetAddTick(
          problemExtraInfo: state.problemExtraInfo,
          problem: this.problem,
        );
      } else if (state is ProblemExtraInfoLoading) {
        return Text("Loading...");
      }
      return Text("Unknown state" + state.toString());
    });
  }

  _buildDislikeAction(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Container(
        child: Row(children: [
      Icon(
        Icons.sentiment_dissatisfied_rounded,
        color: colorScheme.accentColor,
      ),
      SizedBox(
        width: 4,
      ),
      Text("Dislike",
          style: TextStyle(color: colorScheme.accentColor, fontWeight: FontWeight.bold)),
    ]));
  }
}
