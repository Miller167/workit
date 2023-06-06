import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'custom_exceptions.dart';

//  ---------------- API BASE CALLS FILE -----------------
//  This file has all http requests needed (for now) in the app.
//  Basically, it uses GET and POST, but when we send a token or different data,
//  the function changes...
//  In the end we have a parsing function, that returns our custom exceptions
//  when requests fail.

class ApiBaseHelper {
  final String _baseUrl = "http://10.0.2.2:8080/";
  //final String _baseUrl = "http://192.168.1.11 :8080/";

  Future<dynamic> get(String url,
      [String token = '', String tokenType = '']) async {
    var resp;
    final response;
    try {
      if (token == '') {
        response = await http.get(Uri.parse(_baseUrl + url),
            headers: {"Content-Type": "application/json"});
      } else {
        response = await http.get(Uri.parse(_baseUrl + url), headers: {
          "Authorization": "$tokenType $token",
          "Content-Type": "application/json"
        });
      }

      resp = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return resp;
  }

  Future post(String url, Map data) async {
    var resp;
    var body = json.encode(
        data); //data example: Map data = {"email": mail, "password": password};
    try {
      var response = await http.post(Uri.parse(_baseUrl + url),
          headers: {"Content-Type": "application/json"}, body: body);
      resp = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return resp!;
  }

  Future put(String url, Map? data) async {
    var resp;
    var body = json.encode(
        data); //data example: Map data = {"email": mail, "password": password};
    try {
      var response = await http.put(Uri.parse(_baseUrl + url),
          headers: {"Content-Type": "application/json"}, body: body);
      resp = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('api put recieved!');
    return resp!;
  }

  Future delete(String url) async {
    var resp;
    try {
      var response = await http.delete(Uri.parse(_baseUrl + url),
          headers: {"Content-Type": "application/json"});
      resp = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('api delete recieved!');
    return resp!;
  }

  Future authorisedPost(
      String url, String token, String tokenType, Map data) async {
    var resp;
    var body = json.encode(data);
    try {
      var response = await http.post(Uri.parse(_baseUrl + url),
          headers: {
            "Authorization": "$tokenType $token",
            "Content-Type": "application/json"
          },
          body: body);
      resp = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    print('api post recieved!');
    return resp!;
  }

  _returnResponse(http.Response response) {
    var responseJson;
    switch (response.statusCode) {
      case 200:
        if (response.body != '') {
          if (response.bodyBytes.first < 0x7B) {
            responseJson = response.body;
          } else {
            responseJson = json.decode(utf8.decode(response.bodyBytes));
          }
        } else {
          responseJson = response.body;
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString(),
            json.decode(utf8.decode(response.bodyBytes)));
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
