class Todo {
  late int id;
  late String title;
  late bool isChecked;

  Todo({
    required this.id,
    required this.title,
    required this.isChecked,
  });

  Todo.fromMap(Map object) {
    id = object["id"];
    title = object['title'];
    isChecked = object['isChecked'] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isChecked': isChecked,
    };
  }

  List<Object?> toList() {
    return [id, title, isChecked];
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, isChecked: $isChecked}';
  }
}
