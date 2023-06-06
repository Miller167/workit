import 'package:workit/models/user.dart';

class Todo {
  late int id;
  late String title;
  late bool isChecked;
  late User? user;

  Todo(
      {required this.id,
      required this.title,
      required this.isChecked,
      this.user});

  Todo.fromMap(Map object) {
    id = object["id"];
    title = object['title'];
    isChecked = object['isChecked'] ?? false;
    user = object['user'] != null ? User.fromMap(object['user']) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked,
      'user': user?.toMap()
    };
  }

  List<Object?> toList() {
    return [id, title, isChecked, user?.toList()];
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, isChecked: $isChecked, user: $user}';
  }
}
