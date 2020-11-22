import 'package:flutter/material.dart';
import 'package:problemator/widgets/problems/bottom_sheet_add_tick.dart';
import 'package:problemator/widgets/problems/problem_color_indicator.dart';

class ShowProblem extends StatefulWidget {
  final String id;
  ShowProblem({this.id});
  @override
  State<StatefulWidget> createState() => _ShowProblem(id: id);
}

class _ShowProblem extends State<ShowProblem> {
  final String id;
  _ShowProblem({this.id});

  @override
  Widget build(BuildContext context) {
    //_buildBottomSheet(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route #'),
      ),
      body: Container(
        child: Column(
          children: [
            _buildProblemLeftPane(),
            _buildProblemRightPane(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Route name"),
    );
  }

  Widget _buildProblemLeftPane() {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 20),
        child: Column(
          children: [
            Text("6B+"),
            ProblemColorIndicator(
              height: 32,
              width: 32,
              htmlcolour: "#ff0000",
            ),
            Text("Dyno, powerful"),
            Text("17 ascents"),
            Text("1 likes"),
            Text("do like")
          ],
        ),
      ),
    );
  }

  Widget _buildProblemRightPane() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Olli Antikainen"),
                Text("3 weeks ago"),
              ],
            ),
            Row(
              children: [
                Text("Notes"),
                Text("Arets included"),
              ],
            ),
            Text("+ add video beta"),
            Text("Opinions"),
            Text("7A+ jne"),
            SizedBox(
              height: 10,
            ),
            Text("3 dislikes (dangerous)"),
            Text("do dislike"),
          ],
        ),
      ),
    );
  }

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return BottomSheetAddTick();
        });
  }
}
