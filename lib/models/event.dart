import 'dart:ui';
import 'package:workit/models/project.dart';

// Event entity
class Event {
  late String title;
  late String description;
  late DateTime start;
  late DateTime end;
  late bool isAllDay;
  late Project project;

  Event(String title, String description, DateTime start, DateTime end,
      bool isAllDay, Project project) {
    this.title = title;
    this.description = description;
    this.start = start;
    this.end = end;
    this.isAllDay = isAllDay;
    this.project = project;
  }
}
