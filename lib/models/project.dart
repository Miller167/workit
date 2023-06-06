import 'package:workit/models/user.dart';

class Project {
  late int? id;
  late String title;
  late String? description;
  late double? estimatedHours;
  late double? totalHours;
  late User? manager;

  Project(
      {this.id,
      required this.title,
      this.description,
      this.estimatedHours,
      this.totalHours,
      this.manager});

  Project.fromMap(Map object) {
    id = object["id"];
    title = object['title'];
    description = object['description'];
    estimatedHours = object['estimatedHours'];
    totalHours = object['totalHours'];
    manager =
        object['manager'] != null ? User.fromMap(object['manager']) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimatedHours': estimatedHours,
      'totalHours': totalHours,
      'manager': manager?.toMap()
    };
  }

  List<Object?> toList() {
    return [id, title, description, estimatedHours, totalHours, manager];
  }

  Project.empty() {
    id = 0;
    title = '';
    description = null;
    estimatedHours = null;
    totalHours = null;
    manager = null;
  }

  @override
  String toString() {
    return 'Project{id: $id, title: $title, description: $description, estimatedHours: $estimatedHours, totalHours: $totalHours, manager: $manager}';
  }
}
