import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();
}

class _MainFetchDataState extends State<MainFetchData> {
  List list = List();
  var isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response = 
      await
      http.get("https://www.problemator.fi/t/problematorapi/v02/mytop10/");
      if (response.statusCode == 200) {
        list = json.decode(response.body) as List;
          setState(() {
            isLoading = false;
          });
      } else {
        throw Exception('Failed to load data');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problems Data"),
      ),
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(80.0),
      child: RaisedButton(child: Text("Fetch Data"),
      onPressed: () => null,
        ),
      ),
      body: isLoading
      ? Center(
        child: CircularProgressIndicator(),
        )
      : ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10.0),
            title: new Text(list[index]['title']),
          );
        }
      )
    );
  }
}