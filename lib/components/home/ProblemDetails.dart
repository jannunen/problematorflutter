import 'package:flutter/material.dart';
import 'package:problemator/components/api/ProblemListResponse.dart';

class ProblemDetails extends StatelessWidget {

  final Problem problem;

  ProblemDetails({ this.problem });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text('Problem '+this.problem.tag)),
      body : Text('Kirakka')
      );
  }

  

}