import 'package:flutter/material.dart';
import 'package:problemator/blocs/tab/tab.dart';
import 'package:problemator/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:problemator/widgets/widgets.dart';
import 'package:problemator/models/models.dart';
import '../blocs/blocs.dart';
import 'home_screen.i18n.dart';
import '../widgets/profile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Problemator".i18n),
            actions: [
              FilterButton(visible: activeTab == AppTab.home),
              ExtraActions(),
            ],
          ),
          body: BlocListener(
            cubit: BlocProvider.of<ProblemsBloc>(context),
            listener: (BuildContext context, ProblemsState state) {
              if (state is ProblemsErrorLoading) {
                Scaffold.of(context).showBottomSheet(
                    (context) => Container(child: Text("Error:" + state.toString())));
              }
            },
            child: _buildBody(activeTab), //activeTab == AppTab.home ? FilteredProblems() : Stats(),
          ),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addProblemFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addProblem);
            },
            child: Icon(Icons.add),
            tooltip: "Add problem".i18n,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }

  Widget _buildBody(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.home:
        //return MainFetchData();
        return FilteredProblems();
        break;

      case AppTab.profile:
        return Profile();
        break;

      case AppTab.circuits:
        return Stats();
        break;

      default:
        print("Missing tab " + activeTab.toString());
        break;
    }
    return Container();
  }
}
