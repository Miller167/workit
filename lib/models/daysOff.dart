import 'package:workit/models/user.dart';

class DaysOff {
  late int? id;
  late String? concept;
  late DateTime startDatetime;
  late DateTime endDatetime;
  late User? user;
  late int totalDays;

  DaysOff(
      {this.id,
      this.concept,
      required this.startDatetime,
      required this.endDatetime,
      required this.totalDays,
      required this.user});

  DaysOff.fromMap(Map object) {
    id = object["id"];
    concept = object['concept'];
    startDatetime = DateTime.parse(object['startDatetime']);
    endDatetime = DateTime.parse(object['endDatetime']);
    user = object['user'] != null ? User.fromMap(object['user']) : null;
    totalDays = object['totalDays'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'concept': concept,
      'startDatetime': startDatetime.millisecondsSinceEpoch,
      'endDatetime': endDatetime.millisecondsSinceEpoch,
      'totalDays': totalDays,
      'user': user?.toMap()
    };
  }

  List<Object?> toList() {
    return [id, concept, startDatetime, endDatetime, totalDays, user?.toList()];
  }

  @override
  String toString() {
    return 'DaysOff{id: $id, concept: $concept, startDatetime: $startDatetime, endDatetime: $endDatetime, user: $user, totalDays: $totalDays}';
  }
}
