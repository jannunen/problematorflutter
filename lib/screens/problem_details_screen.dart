import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/blocs/problems/problems.dart';
import 'package:problemator/core/core.dart';
import 'package:problemator/flutter_problems_keys.dart';
import 'package:problemator/screens/screens.dart';

class DetailsScreen extends StatelessWidget {
    final String id;
 
    DetailsScreen({Key key, @required this.id})
        : super(key: key ?? ArchSampleKeys.problemDetailsScreen);
 
    @override
    Widget build(BuildContext context) {
      return BlocBuilder<ProblemsBloc, ProblemsState>(
        builder: (context, state) {
          final problem = (state as ProblemsLoaded)
              .problems
              .firstWhere((problem) => problem.id == id, orElse: () => null);
          final localizations = ArchSampleLocalizations.of(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(localizations.problemDetails),
              actions: [
                IconButton(
                  tooltip: localizations.deleteProblem,
                  key: ArchSampleKeys.deleteProblemButton,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    /*
                    BlocProvider.of<ProblemsBloc>(context).add(DeleteProblem(problem));
                    Navigator.pop(context, problem);
                    */
                  },
                )
              ],
            ),
            body: problem == null
                ? Container(key: FlutterProblemsKeys.emptyDetailsContainer)
                : Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Checkbox(
                                  key: FlutterProblemsKeys.detailsScreenCheckBox,
                                  value: problem.ticked != null,

                             onChanged: (_) {
                                /*
                                    BlocProvider.of<ProblemsBloc>(context).add(
                                      UpdateProblem(
                                        problem.copyWith(complete: !problem.complete),
                                      ),
                                    );
                                    */
                                  }),
                                  
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: '${problem.id}__heroTag',
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 16.0,
                                      ),
                                      child: Text( problem.tag),
                                    ),
                                  ),
                                  Text( problem.tag),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              key: ArchSampleKeys.editProblemFab,
              tooltip: localizations.editProblem,
              child: Icon(Icons.edit),
              onPressed: () => {
              } 
             ,
            ),
          );
        },
      );
    }
  }