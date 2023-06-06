import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workit/resources/api_calls.dart';
import '../resources/constants.dart';
import '../models/event.dart';
import '../models/project.dart';

//  ------------------ Creating and Editing an event screen -----------------
//  This screen is called after a button in the Schedule screen is pressed.
//  Returns a page with a form. It's fields are the ones necessary to create an event.
//  When created it calls the api and returns main page.

class EventEditingScreen extends StatefulWidget {
  final List<Project> projects;

  const EventEditingScreen({Key? key, required this.projects})
      : super(key: key);

  @override
  State<EventEditingScreen> createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  late DateTime startDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  bool allDay = false;
  late Project project;
  late List<DropdownMenuItem<Project>> items;

  final DateFormat format = DateFormat('dd/MM/yyyy');

  @override
  initState() {
    super.initState();
    project = widget.projects.first;
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay(hour: startTime.hour + 2, minute: startTime.minute);
    items = widget.projects.map<DropdownMenuItem<Project>>((Project value) {
      return DropdownMenuItem<Project>(
        value: value,
        child: Text(
          value.title,
          style: TextStyle(fontSize: 15),
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startController.dispose();
    endController.dispose();

    super.dispose();
  }

  Future saveForm() async {
    DateTime start;
    DateTime? end;
    if (!allDay) {
      start = DateTime(startDate.year, startDate.month, startDate.day,
          startTime.hour, startTime.minute);
      end = DateTime(startDate.year, startDate.month, startDate.day,
          endTime.hour, endTime.minute);
    } else {
      start = startDate;
      end = null;
    }

    final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        allDay: allDay,
        start: start,
        end: end,
        project: project,
        user: user);

    var response = await createEvent(event.toMap());

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    //DateTime parsedTime = DateFormat.jm().parse(startTime.format(context).toString());
    DateTime parsedTime = DateTime(startDate.year, startDate.month,
        startDate.day, startTime.hour, startTime.minute);
    String formattedTime = DateFormat('HH:mm').format(parsedTime);
    startController.text = formattedTime;

    //DateTime parsedTime2 = DateFormat.jm().parse(endTime.format(context).toString());
    DateTime parsedTime2 = DateTime(startDate.year, startDate.month,
        startDate.day, endTime.hour, endTime.minute);
    String formattedTime2 = DateFormat('HH:mm').format(parsedTime2);
    endController.text = formattedTime2;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: Text('New event', style: TextStyle(color: kGrey5)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kGrey4,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                saveForm().then((value) => Navigator.pop(context));
              }
            },
            child: Text('Save',
                style: TextStyle(
                    color: secondaryColor, fontSize: media.height / 40)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    style: TextStyle(fontSize: media.height / 30),
                    decoration: const InputDecoration(
                      hintText: 'Add title',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (title) => title != null && title.isEmpty
                        ? 'Title cannot be empty'
                        : null,
                  ),
                  SizedBox(
                    height: media.height / 30,
                  ),
                  Text('Description',
                      style: TextStyle(
                          fontSize: media.height / 30, color: Colors.black54)),
                  SizedBox(
                    height: media.height / 40,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    style: TextStyle(fontSize: media.height / 50),
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: media.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                      fontSize: media.height / 30, color: Colors.black54),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DateTimeField(
                    initialValue: startDate,
                    resetIcon: null,
                    format: format,
                    onChanged: (value) {
                      setState(() {
                        startDate = value!;
                      });
                    },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1980),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
                SizedBox(
                  width: media.width / 10,
                ),
                Row(
                  children: [
                    Text(
                      'Lasts all day',
                      style: TextStyle(
                          fontSize: media.height / 40, color: Colors.black54),
                    ),
                    Checkbox(
                      fillColor:
                          MaterialStateProperty.all<Color>(secondaryColor),
                      checkColor: Colors.white,
                      value: allDay,
                      onChanged: (bool? value) {
                        setState(() {
                          allDay = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: media.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Period',
                  style: TextStyle(
                      fontSize: media.height / 30, color: Colors.black54),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: startController,
                    style: TextStyle(color: allDay ? kGrey2 : kGrey5),
                    enabled: !allDay,
                    //initialValue: startTime.format(context),
                    onTap: () async {
                      startTime = (await showTimePicker(
                          context: context, initialTime: startTime))!;
                      if (startTime != null) {
                        setState(() {
                          DateTime parsedTime = DateFormat.jm()
                              .parse(startTime.format(context).toString());
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);
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
                      color: allDay ? kGrey2 : kGrey5),
                ),
                SizedBox(
                  width: media.width / 12,
                ),
                Flexible(
                  child: TextFormField(
                    controller: endController,
                    style: TextStyle(color: allDay ? kGrey2 : kGrey5),
                    enabled: !allDay,
                    //initialValue: endTime.format(context),
                    onTap: () async {
                      endTime = (await showTimePicker(
                          context: context, initialTime: endTime))!;
                      if (endTime != null) {
                        setState(() {
                          DateTime parsedTime = DateFormat.jm()
                              .parse(endTime.format(context).toString());
                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Project',
                  style: TextStyle(
                      fontSize: media.height / 30, color: Colors.black54),
                ),
              ],
            ),
            DropdownButton<Project>(
              isExpanded: true,
              // Step 3.
              value: project,
              // Step 4.
              items: items,
              // Step 5.
              onChanged: (Project? newValue) {
                setState(() {
                  project = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
