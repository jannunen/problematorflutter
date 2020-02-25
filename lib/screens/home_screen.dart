import 'package:flutter/material.dart';
import 'package:problemator/blocs/tab/tab.dart';
import 'package:problemator/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/localization.dart';
import 'package:problemator/models/models.dart';

class HomeScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return BlocBuilder<TabBloc, AppTab>(
        builder: (context, activeTab) {
          return Scaffold(
            appBar: AppBar(
              title: Text(FlutterBlocLocalizations.of(context).appTitle),
              actions: [
                FilterButton(visible: activeTab == AppTab.home),
                ExtraActions(),
              ],
            ),
            body: _buildBody(activeTab),              //activeTab == AppTab.home ? FilteredProblems() : Stats(),
            floatingActionButton: FloatingActionButton(
              key: ArchSampleKeys.addProblemFab,
              onPressed: () {
                Navigator.pushNamed(context, ArchSampleRoutes.addProblem);
              },
              child: Icon(Icons.add),
              tooltip: ArchSampleLocalizations.of(context).addProblem,
            ),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                  BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
            ),
          );
        },
      );
    }

    Widget _buildBody(AppTab activeTab) {
      switch (activeTab) {
        case AppTab.home:
          return FilteredProblems();
        break;

        case AppTab.stats:
          return Stats();
        break;

        default:
        print("Missing tab "+ activeTab.toString());
        break;
      }
      return Container();
    }
  }