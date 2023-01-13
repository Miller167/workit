import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/constants.dart';
import '../resources/functions.dart';
import '../models/event.dart';
import '../models/project.dart';

//  ------------------ Creating and Editing an event screen -----------------
//  This screen is called after a button in the Schedule screen is pressed.
//  Returns a page with a form. It's fields are the ones necessary to create an event.
//  When created it calls the api and returns main page.

class EventEditingScreen extends StatefulWidget {
  final Event? event;

  const EventEditingScreen({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingScreen> createState() => _EventEditingScreenState();
}

class _EventEditingScreenState extends State<EventEditingScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime startDate;
  late DateTime endDate;

  @override
  initState() {
    super.initState();
    if (widget.event == null) {
      startDate = DateTime.now();
      endDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey2,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0),
            onPressed: () {
              saveForm().then((value) => Navigator.pop(context));
            },
            icon: const Icon(Icons.done),
            label: const Text('SAVE'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                      hintText: 'Add title',
                      border: UnderlineInputBorder(),
                    ),
                    validator: (title) => title != null && title.isEmpty
                        ? 'Title cannot be empty'
                        : null,
                    onFieldSubmitted: (_) => saveForm(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'START',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: buildDropdownField(
                            text: toDate(startDate),
                            onClicked: () => pickStartDateTime(pickDate: true),
                          ),
                        ),
                        Expanded(
                          child: buildDropdownField(
                            text: toTime(startDate),
                            onClicked: () => pickStartDateTime(pickDate: false),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'END',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: buildDropdownField(
                            text: toDate(endDate),
                            onClicked: () => pickEndDateTime(pickDate: true),
                          ),
                        ),
                        Expanded(
                          child: buildDropdownField(
                            text: toTime(endDate),
                            onClicked: () => pickEndDateTime(pickDate: false),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickStartDateTime({required bool pickDate}) async {
    final date = await pickDateTime(startDate, pickDate: pickDate);

    if (date == null) return;
    if (date.isAfter(endDate)) {
      endDate = DateTime(
          date.year, date.month, date.day, endDate.hour, endDate.minute);
    }
    setState(() => startDate = date);
  }

  Future pickEndDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      endDate,
      pickDate: pickDate,
      firstDate: pickDate ? startDate : null,
    );

    if (date == null) return;
    if (date.isAfter(endDate)) {
      endDate = DateTime(
          date.year, date.month, date.day, endDate.hour, endDate.minute);
    }
    setState(() => endDate = date);
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      Project project = Project('Projecte 1', Colors.blue);
      final event = Event(titleController.text, 'Description', startDate,
          endDate, false, project);

      print(event);
    }
  }
}
