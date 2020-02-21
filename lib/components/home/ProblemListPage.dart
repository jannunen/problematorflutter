import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:problemator/components/api/ApiResponse.dart';
import 'package:problemator/components/api/ProblemListResponse.dart';
import 'package:problemator/components/api/ProblematorBloc.dart';
import 'package:problemator/components/api/ApiBaseHelper.dart';


class ProblemListPage extends StatefulWidget {
  @override
  _ProblemListPageState createState() => _ProblemListPageState();
}

class _ProblemListPageState  extends State<ProblemListPage> {

  ProblemBloc _bloc;

 @override
  void initState() {
    super.initState();
    _bloc = ProblemBloc();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Problem list')),
      backgroundColor: Colors.black54,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchProblemList(),
        child: StreamBuilder<ApiResponse<List<Problem>>>(
          stream: _bloc.problemListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return ProblemList(problemList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchProblemList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class ProblemList extends StatelessWidget {
  final List<Problem> problemList;

  const ProblemList({Key key, this.problemList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: problemList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                'https://image.tmdb.org/t/p/w342${problemList[index].id}',
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}