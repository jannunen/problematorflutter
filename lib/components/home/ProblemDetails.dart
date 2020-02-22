import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:problemator/api/ApiResponse.dart';
import 'package:problemator/api/blocs/ProblemDetailsBloc.dart';
import 'package:problemator/models/Problem.dart';
import 'package:spinner_input/spinner_input.dart';

class ProblemDetails extends StatefulWidget {

  final Problem problem;
  ProblemDetails({Key key, this.problem}) : super(key: key);

  _ProblemDetailsState createState() => _ProblemDetailsState(problem);
}

class _ProblemDetailsState extends State<ProblemDetails> {

  ProblemDetailsBloc _bloc;

  final Problem problem;
  final int padding = 8;
  final double fontSizeTiny = 14;
  final double fontSizeSmall = 20;
  final double fontSizeMedium = 30;
  final double fontSizeLarge = 40;
  final double fontSizeHuge = 80;


  double _tries = 0;
  String _gradeOpinion = null;

  _ProblemDetailsState( this.problem );

  void _setTries(tries) {
    setState(() {
      _tries = tries;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title : Text('Problem '+this.problem.tag)),
        body : GridView.count(
        crossAxisCount: 2,
        children : [
          gradeCell(),likesCell(),
          triesCell(),gradeOpinionCell(),
          StreamBuilder<ApiResponse<Problem>>(
            stream : _bloc.problemDetailsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Text("Loading...");
                  case Status.COMPLETED:
                    return _buildLoadedDetails(snapshot.data.data);
                  break;
                  case Status.ERROR:
                    return Text("Oi ei");

                }
              } 
              return Container();
        }),
          doLikeCell(),toolsCell()
          // Do betavideo adding later
        ])
        );
  }
  Container _buildLoadedDetails(Problem p) {

    return Container(
      child : GridView.count(
        crossAxisCount: 2,
      children: <Widget>[
          ascentsCell(p),opinionsCell(p),
    ]));
  }

  gradeCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
      child :  Column(
        mainAxisSize : MainAxisSize.min,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          Text(this.problem.gradename,
                    style: TextStyle(fontSize: this.fontSizeHuge, fontWeight: FontWeight.bold),
          ),
          Text(this.problem.tag,
                    style: TextStyle(fontSize: this.fontSizeTiny, fontWeight: FontWeight.bold, color : Colors.grey[600]),
          )
        ])
      );
  }

  likesCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      thumbsUbDownRow(),
      Text('by '+this.problem.author,
      style : TextStyle(fontSize: this.fontSizeSmall)),
      Text(this.problem.addedrelative,
      style : TextStyle(fontSize: this.fontSizeSmall)),
    ])
    );
  }

  triesCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [SpinnerInput(
                    spinnerValue: _tries,
                    minValue: 0,
                     middleNumberWidth: 50,
                  middleNumberStyle: TextStyle(fontSize: this.fontSizeLarge),
                    maxValue: 100,
                    onChange: (newValue) {
                      _setTries(newValue);
                    },
                  ),Text('Tries')],
                ));
  }

  gradeOpinionCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
     children : [DropdownButton<String>(
    value: this._gradeOpinion,
    icon: Icon(Icons.arrow_downward),
    iconSize: 30,
    elevation: 20,
    style: TextStyle(
      color: Colors.black,
      fontSize: this.fontSizeLarge,
    ),
    underline:       Container(
    ),
    onChanged: (String newValue) {
      setState(() {
        _gradeOpinion = newValue;
      });
    },
    items: <String>['6C', '6C+', '7A', '7A+','7B','7B+','7C']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  ),Text('Grade opinion')]
    
    ));
  }

  ascentsCell(Problem p) {
    return Padding(
      padding: EdgeInsets.all(8.0), 
      child :  Column(
        mainAxisSize : MainAxisSize.min,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          Text(p.ascentcount,
                    style: TextStyle(fontSize: this.fontSizeLarge, fontWeight: FontWeight.bold),
          ),
          Text("Global ascents",
                    style: TextStyle(fontSize: this.fontSizeTiny, fontWeight: FontWeight.bold, color : Colors.grey[600]),
          )
        ])
      );
  }

  opinionsCell(Problem p) {
    return Padding(
      padding: EdgeInsets.all(8.0), 
    child: Text('Opinions'));
  }
  
  doLikeCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
    child: Text('Like'));
  }

  toolsCell() {
    return Padding(
      padding: EdgeInsets.all(8.0), 
    child: Text('Tools'));
  }

  thumbsUbDownRow() {
    return Row(
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
      thumbsUp(),
      loves(),
      thumbsDown()
    ]);
  }

  thumbsUp() {
    return Row(children: <Widget>[
      Text(this.problem.cLike,
      style:  TextStyle(fontSize: 26)),
      Icon(FontAwesomeIcons.thumbsUp)
    ],
    mainAxisAlignment: MainAxisAlignment.spaceAround);
  }
  loves() {
    return Row(children: <Widget>[
      Text(this.problem.cLove,
      style:  TextStyle(fontSize: 26)),
      Icon(FontAwesomeIcons.heart,
      color:  Colors.red[500],)
    ],
    mainAxisAlignment: MainAxisAlignment.spaceAround);
  }
  thumbsDown() {
    return Row(children: <Widget>[
      Text(this.problem.cDislike,
      style:  TextStyle(fontSize: 26)),
      Icon(FontAwesomeIcons.thumbsDown)
    ],
    mainAxisAlignment: MainAxisAlignment.spaceAround);

  }

  @override
  void initState() {
    super.initState();
    // Find problem details
    _bloc = ProblemDetailsBloc();
    _bloc.fetchProblemDetails(this.problem.id);

  }
}