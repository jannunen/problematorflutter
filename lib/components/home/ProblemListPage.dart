import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:problemator/components/api/ApiResponse.dart';
import 'package:problemator/components/api/ProblemListResponse.dart';
import 'package:problemator/components/api/ProblematorBloc.dart';
import 'package:problemator/components/api/ApiBaseHelper.dart';
import 'package:problemator/components/home/ProblemDetails.dart';


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
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 1.0,
              ),
              child: /*
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProblemDetails( problem : problemList[index] )));
                  },
                  
                  child :
                  */
                   makeListItem(context,problemList[index])
                  /*
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      color: Color(0xFF333333),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                        child: Text(
                          problemList[index].tag,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )
                  )
                  */
                  );

      } // itemBuilder
    ); // builder

  }

  ListTile makeListItem(BuildContext context, Problem problem) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Text(problem.gradename, style: TextStyle(color : Colors.white, fontWeight: FontWeight.bold, fontSize : 28 )),
          ),
          title: Text(
            problem.tag,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
    

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(problem.gradename,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProblemDetails( problem : problem )));
          },
        );

}

