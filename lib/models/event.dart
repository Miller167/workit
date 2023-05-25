import 'dart:ui';
import 'package:workit/models/project.dart';

// Event entity
class Event {
  late int? id;
  late String title;
  late String? description;
  late DateTime startDatetime;
  late DateTime? endDatetime;
  late bool allDay;
  late Project? project;

  Event(
      {this.id,
      required this.title,
      this.description,
      required DateTime start,
      DateTime? end,
      required this.allDay,
      this.project}) {
    startDatetime = start;
    endDatetime = end;
  }

  Event.fromMap(Map object) {
    id = object["id"];
    title = object['title'];
    description = object['description'];
    startDatetime = DateTime.parse(object['startDatetime']);
    endDatetime = object['endDatetime'] != null
        ? DateTime.parse(object['endDatetime'])
        : null;
    allDay = object['allDay'] ?? false;
    project = Project.fromMap(object['project']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDatetime': startDatetime.millisecondsSinceEpoch,
      'endDatetime': endDatetime?.millisecondsSinceEpoch,
      'allDay': allDay,
      'project': project?.toMap()
    };
  }

  List<Object?> toList() {
    return [
      id,
      title,
      description,
      startDatetime,
      endDatetime,
      allDay,
      project
    ];
  }

  @override
  String toString() {
    return 'Event{id: $id, title: $title, description: $description, startDatetime: $startDatetime, endDatetime: $endDatetime, allDay: $allDay, project: $project}';
  }
}
