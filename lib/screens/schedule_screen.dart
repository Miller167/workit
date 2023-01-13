import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:workit/resources/widgets.dart';
import 'package:workit/screens/event_editing_screen.dart';
import 'package:intl/intl.dart';
import '../resources/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// ------------------- SCHEDULE SCREEN ------------------
//  This is one of the NavBar options. The body returns a calendar (with a daily view).
//  It also has a floating button for adding an event. This button calls the Event Editing Screen.

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Stack(
      children: [
        SfCalendar(
          showDatePickerButton: true,
          showNavigationArrow: true,
          showWeekNumber: true,
          firstDayOfWeek: 1,
          todayHighlightColor: kGrey3,
          cellBorderColor: kGrey3,
          backgroundColor: kGrey1,
          initialDisplayDate: DateTime.now(),
          initialSelectedDate: DateTime.now(),
          dataSource: MeetingDataSource(getAppointments()),
        ),
        Positioned(
          bottom: media.size.height / 8,
          right: media.size.width / 20,
          child: CustomCupertinoButton(
            context: context,
            height: 60,
            width: 60,
            backgroundColor: kGrey4,
            content: const Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: 20,
              ),
            ),
            borderRadius: 100,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventEditingScreen()));
            },
          ),
        ),
      ],
    );
  }
}

//This is where we call the api and we return to the screen all the parsed events
List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      //Test event
      startTime: startTime,
      endTime: endTime,
      subject: 'Conference',
      notes: "This is a test",
      color: kGrey3));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
