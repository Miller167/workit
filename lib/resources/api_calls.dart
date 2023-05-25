import 'package:flutter/material.dart';
import 'dart:convert';

import 'api_base_helper.dart';

Future<dynamic> getUsers() async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("users")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> getUserById(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("users")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> getTodos() async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("todos")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> createTodo(Map data) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .post("todos", data)
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

/*
Future<dynamic> deleteTodo(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .post("deleteTodo/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}
*/

Future<dynamic> deleteTodo(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .delete("todos/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> createEvent(Map data) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .post("events", data)
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> getEvents() async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("events")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> updateEvent(int id, Map data) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .put("events/$id", data)
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> deleteEvent(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .delete("events/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> getProjects() async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("projects")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}