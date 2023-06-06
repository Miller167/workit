import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:workit/resources/api_calls.dart';
import 'package:workit/screens/event_editing_screen.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';
import '../models/project.dart';
import '../resources/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../widgets/CustomCupertinoButton.dart';

// ------------------- SCHEDULE SCREEN ------------------
//  This is one of the NavBar options. The body returns a calendar (with a daily view).
//  It also has a floating button for adding an event. This button calls the Event Editing Screen.

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<Event> events = [];
  late List<Project> projects = [Project.empty()];

  //selected event data
  late int selectedId;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  late DateTime selectedDate;
  late TimeOfDay selectedStart;
  late TimeOfDay selectedEnd;
  late bool selectedAllDay;
  late int selectedProject;
  late DateTime parsedTime;
  late String formattedTime;
  late List<DropdownMenuItem<int>> items;

  final DateFormat format = DateFormat('dd/MM/yyyy');

  Future<bool> getData() async {
    events.clear();
    projects.clear();
    projects = [Project.empty()];
    List response = await getEventsByUserId(user.id ?? 0);
    List response2 = await getProjectsByUserId(user.id ?? 0);
    response.forEach((element) {
      events.add(Event.fromMap(element));
    });
    response2.forEach((element) {
      projects.add(Project.fromMap(element));
    });

    items = projects.map<DropdownMenuItem<int>>((Project value) {
      return DropdownMenuItem<int>(
        value: value.id,
        child: Text(
          value.title,
          style: TextStyle(fontSize: 15),
        ),
      );
    }).toList();
    return true;
  }

  //This is where we call the api and we return to the screen all the parsed events
  List<CustomAppointment> getAppointments() {
    List<CustomAppointment> meetings = <CustomAppointment>[];

    events.forEach((element) {
      meetings.add(CustomAppointment(
          id: element.id,
          startTime: element.startDatetime,
          endTime: element.endDatetime ?? DateTime.now(),
          isAllDay: element.allDay,
          subject: element.title,
          notes: element.description,
          color: Colors.lightGreen,
          project: element.project ?? Project.empty()));
    });
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    bool enabledForm = false;

    Future<void> removeEvent() async {
      var response = await deleteEvent(selectedId)
          .onError((error, stackTrace) => print(error));

      print(response);
    }

    Future<void> sendEvent() async {
      DateTime start;
      DateTime? end;
      if (!selectedAllDay) {
        start = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedStart.hour, selectedStart.minute);
        end = DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
            selectedEnd.hour, selectedEnd.minute);
      } else {
        start = selectedDate;
        end = null;
      }

      final event = Event(
          id: selectedId,
          title: titleController.text,
          description: descriptionController.text,
          allDay: selectedAllDay,
          start: start,
          end: end,
          project:
              projects.firstWhere((element) => element.id == selectedProject),
          user: user);

      var response = await updateEvent(event.id ?? 0, event.toMap())
          .onError((error, stackTrace) => print(error));

      print(response);
    }

    void calendarTapped(CalendarTapDetails details) {
      if (details.targetElement == CalendarElement.appointment ||
          details.targetElement == CalendarElement.agenda) {
        //final Appointment appointmentDetails = details.appointments![0];
        final CustomAppointment appointmentDetails = details.appointments![0];
        selectedId = int.parse(appointmentDetails.id.toString());
        titleController.text = appointmentDetails.subject;
        descriptionController.text = appointmentDetails.notes!;
        selectedDate = appointmentDetails.startTime;
        selectedStart = TimeOfDay.fromDateTime(appointmentDetails.startTime);
        selectedEnd = TimeOfDay.fromDateTime(appointmentDetails.endTime);
        selectedAllDay = appointmentDetails.isAllDay;
        /*int projectId = int.parse(appointmentDetails.subject ?? '0');
        selectedProject = projects.firstWhere((element) => element.id == projectId);*/
        selectedProject = appointmentDetails.project.id!;

        String formattedTime =
            DateFormat('HH:mm').format(appointmentDetails.startTime);
        startController.text = formattedTime;

        formattedTime = DateFormat('HH:mm').format(appointmentDetails.endTime);
        endController.text = formattedTime;

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter secondSetState) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(enabledForm ? 'Edit event' : 'View event'),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: titleController,
                            enabled: enabledForm,
                            validator: (title) => title != null && title.isEmpty
                                ? 'Title cannot be empty'
                                : null,
                          ),
                          SizedBox(
                            height: media.height / 20,
                          ),
                          TextFormField(
                            controller: descriptionController,
                            enabled: enabledForm,
                            maxLines: 2,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(2),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0.5, color: kGrey4)),
                            ),
                          ),
                          SizedBox(
                            height: media.height / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: DateTimeField(
                                  enabled: enabledForm,
                                  initialValue: selectedDate,
                                  resetIcon: null,
                                  format: format,
                                  onChanged: (value) {
                                    secondSetState(() {
                                      selectedDate = value!;
                                    });
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1980),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Lasts all day',
                                    style: TextStyle(
                                        fontSize: media.height / 40,
                                        color: Colors.black54),
                                  ),
                                  Checkbox(
                                    fillColor: MaterialStateProperty.all<Color>(
                                        secondaryColor),
                                    checkColor: Colors.white,
                                    value: selectedAllDay,
                                    onChanged: (bool? value) {
                                      if (enabledForm) {
                                        secondSetState(() {
                                          selectedAllDay = !selectedAllDay;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: startController,
                                  style: TextStyle(
                                      color: selectedAllDay ? kGrey2 : kGrey5),
                                  enabled:
                                      enabledForm ? !selectedAllDay : false,
                                  onTap: () async {
                                    selectedStart = (await showTimePicker(
                                        context: context,
                                        initialTime: selectedStart))!;
                                    if (selectedStart != null) {
                                      secondSetState(() {
                                        DateTime parsedTime = DateFormat.jm()
                                            .parse(selectedStart
                                                .format(context)
                                                .toString());
                                        String formattedTime =
                                            DateFormat('HH:mm')
                                                .format(parsedTime);
                                        startController.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: media.width / 12,
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                    fontSize: media.height / 45,
                                    color: selectedAllDay ? kGrey2 : kGrey5),
                              ),
                              SizedBox(
                                width: media.width / 12,
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: endController,
                                  style: TextStyle(
                                      color: selectedAllDay ? kGrey2 : kGrey5),
                                  enabled:
                                      enabledForm ? !selectedAllDay : false,
                                  onTap: () async {
                                    selectedEnd = (await showTimePicker(
                                        context: context,
                                        initialTime: selectedEnd))!;
                                    if (selectedEnd != null) {
                                      secondSetState(() {
                                        DateTime parsedTime = DateFormat.jm()
                                            .parse(selectedEnd
                                                .format(context)
                                                .toString());
                                        String formattedTime =
                                            DateFormat('HH:mm')
                                                .format(parsedTime);
                                        endController.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: media.height / 30,
                          ),
                          DropdownButton<int>(
                            value: selectedProject,
                            isExpanded: true,
                            onChanged: (int? value) {
                              // This is called when the user selects an item.
                              secondSetState(() {
                                selectedProject = value!;
                              });
                            },
                            items: enabledForm ? items : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          removeEvent().then((value) => Navigator.pop(context));
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: secondaryColor),
                        )),
                    TextButton(
                        onPressed: () {
                          var value = enabledForm;
                          secondSetState(() {
                            enabledForm = !enabledForm;
                          });
                          if (value) {
                            if (_formKey.currentState!.validate()) {
                              sendEvent()
                                  .then((value) => Navigator.pop(context));
                            }
                          }
                        },
                        child: Text(
                          enabledForm ? 'Finish' : 'Edit',
                          style: TextStyle(color: secondaryColor),
                        )),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(enabledForm ? 'Cancel' : 'Close',
                            style: TextStyle(color: secondaryColor))),
                  ],
                );
              });
            }).then((_) => setState(() {}));
      }
    }

    return SafeArea(
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                SfCalendar(
                  allowedViews: const <CalendarView>[
                    CalendarView.day,
                    CalendarView.workWeek,
                    CalendarView.week,
                    CalendarView.month,
                  ],
                  showDatePickerButton: true,
                  showNavigationArrow: true,
                  showWeekNumber: true,
                  firstDayOfWeek: 1,
                  todayHighlightColor: secondaryColor,
                  cellBorderColor: kGrey3,
                  backgroundColor: primaryColor,
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  dataSource: MeetingDataSource(getAppointments()),
                  headerStyle: CalendarHeaderStyle(),
                  onTap: calendarTapped,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CustomCupertinoButton(
                    context: context,
                    height: media.height / 12,
                    width: media.height / 12,
                    backgroundColor: secondaryColor,
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
                              builder: (context) => EventEditingScreen(
                                    projects: projects,
                                  )));
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            print(snapshot.stackTrace);
            return const Center(
              child: Text(
                'An error occurred',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CustomAppointment extends Appointment {
  Project project;

  CustomAppointment(
      {required super.startTime,
      required super.endTime,
      super.subject,
      super.id,
      super.notes,
      super.isAllDay,
      super.color,
      super.endTimeZone,
      super.location,
      super.startTimeZone,
      required this.project});
}
