import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:problemator/api/ApiExceptions.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:problemator/components/cache/MyCacheManager.dart';
import 'package:problemator/core/utils.dart';

class ApiHelper {
  final String _baseUrl = "https://beta.problemator.fi/t/problematorapi/v03/";

  Future<dynamic> get(String url, {Map<String, dynamic> params, bool useCache = true}) async {
    print('Api GET, url $_baseUrl' + '$url');
    try {
      var file = await MyCacheManager().getSingleFile(_baseUrl + url, useCache: useCache);
      if (file != null && await file.exists()) {
        var res = await file.readAsString();
        return _returnResponse(new http.Response(res, 200));
      }
      return _returnResponse(new http.Response(null, 404));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (error) {
      throw FetchDataException(error);
    }
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api POST, url $_baseUrl' + '$url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    } catch (error) {
      print(error);
      throw FetchDataException('Error in post (' + error.toString() + ')');
    }
    print('api post DONE.');
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
        String body = response.body.toString();
        body = trimRight(trimLeft(body, "("), ")");
        //String responseJson = json.decode(utf8.decode(response.bodyBytes));
        var responseJson = json.decode(body);
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

  const Error({Key key, this.errorMessage, this.onRetryPressed}) : super(key: key);

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
