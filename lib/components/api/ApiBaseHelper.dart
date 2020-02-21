import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:problemator/components/api/ApiExceptions.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {

  final String _baseUrl = "https://www.problemator.fi/t/problematorapi/v02/";

  Future<dynamic> get(String url) async {
    //print('Api GET, url $url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

 Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

    Future<dynamic> delete(String url) async {
      print('Api delete, url $url');
      var apiResponse;
      try {
        final response = await http.delete(_baseUrl + url);
        apiResponse = _returnResponse(response);
      } on SocketException {
        print('No net');
        throw FetchDataException('No Internet connection');
      }
      print('api delete.');
      return apiResponse;
    }

    dynamic _returnResponse(http.Response response) {
      switch (response.statusCode) {
        case 200:
        // Strip JSONP stuff out from response
          //String responseJson = json.decode(utf8.decode(response.bodyBytes));
          var responseJson = json.decode(response.body.toString());
          return responseJson;

        case 400:
          throw BadRequestException(response.body.toString());
        case 401:
        case 403:
          throw UnauthorisedException(response.body.toString());
        case 500:
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }

    }

}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}

