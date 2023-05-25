import 'dart:ui';
import 'package:workit/models/project.dart';
import 'package:workit/models/todo.dart';

class User {
  late int? id;
  late String email;
  late String username;
  late String fullName;
  late bool administrator;
  late double totalDaysOff;
  //late DaysOff daysOffDone;
  late List<Project>? managedProjects;
  late List<Project>? collaboratedProjects;
  late List<Todo>? createdTodos;

  User(
      {this.id,
      required this.email,
      required this.username,
      required this.fullName,
      required this.administrator,
      required this.totalDaysOff,
      this.collaboratedProjects,
      this.createdTodos,
      this.managedProjects});

  User.fromMap(Map object) {
    List<Project> collaborated = [];
    List<Todo> created = [];
    List<Project> managed = [];
    object['collaboratedProjects']
        .forEach((element) => collaborated.add(Project.fromMap(element)));
    if (object['managedProjects'] != null) {
      object['managedProjects']
          .forEach((element) => managed.add(Project.fromMap(element)));
    }
    object['createdTodos']
        .forEach((element) => created.add(Todo.fromMap(element)));
    id = object["id"];
    email = object['email'];
    username = object['username'];
    fullName = object['fullName'];
    administrator = object['administrator'];
    totalDaysOff = object['totalDaysOff'];
    collaboratedProjects = collaborated;
    managedProjects = managed;
    createdTodos = created;
  }

  Map<String, dynamic> toMap() {
    List<Map> adminProjects = [];
    List<Map> colProjects = [];
    List<Map> todos = [];
    collaboratedProjects?.forEach((element) {
      colProjects.add(element.toMap());
    });
    managedProjects?.forEach((element) {
      adminProjects.add(element.toMap());
    });
    createdTodos?.forEach((element) {
      todos.add(element.toMap());
    });
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullName': fullName,
      'administrator': administrator,
      'totalDaysOff': totalDaysOff,
      'collaboratedProjects': colProjects,
      'managedProjects': adminProjects,
      'createdTodos': todos
    };
  }

  List<Object?> toList() {
    return [
      id,
      email,
      username,
      fullName,
      administrator,
      totalDaysOff,
      managedProjects?.toList(),
      collaboratedProjects?.toList(),
      createdTodos?.toList()
    ];
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, fullName: $fullName, administrator: $administrator, totalDaysOff: $totalDaysOff, managedProjects: $managedProjects, collaboratedProjects: $collaboratedProjects, createdTodos: $createdTodos}';
  }
}
