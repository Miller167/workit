import 'api_base_helper.dart';

/*Future<dynamic> getUsers() async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("users")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}*/

// ---------------- USER ---------------

Future<dynamic> getUserById(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("users")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> login(Map data) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .post("users/login", data)
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

// --------------------------------------

// ---------------- TODOS ---------------

Future<dynamic> getTodosByUserId(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("todos/userId/$id")
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

Future<dynamic> deleteTodo(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .delete("todos/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}
// --------------------------------------

// ---------------- EVENT ---------------

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

Future<dynamic> getEventsByUserId(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("events/userId/$id")
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
// --------------------------------------

// --------------- PROJECT --------------

Future<dynamic> getProjectsByUserId(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("projects/userId/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}
// --------------------------------------

// -------------- DAYS OFF --------------

Future<dynamic> getDaysOffByUserId(int id) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .get("daysoff/userId/$id")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

Future<dynamic> createDaysOff(Map data) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  final response = await _helper
      .post("daysoff", data)
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

// --------------------------------------

// ---------------- SHIFT ---------------
Future<dynamic> requestShift(int userId) async {
  ApiBaseHelper _helper = ApiBaseHelper();
  var response = await _helper
      .get("shifts/request/$userId")
      .onError((error, stackTrace) => throw Exception(error));

  return response;
}

// --------------------------------------
