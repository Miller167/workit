import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:workit/resources/api_calls.dart';
import '../models/daysOff.dart';
import '../models/user.dart';
import '../resources/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DaysOffScreen extends StatefulWidget {
  const DaysOffScreen({Key? key}) : super(key: key);

  @override
  State<DaysOffScreen> createState() => _DaysOffScreenState();
}

class _DaysOffScreenState extends State<DaysOffScreen> {
  TextEditingController conceptController = TextEditingController();
  final DateRangePickerController dateController = DateRangePickerController();
  List<DaysOff> daysOff = [];
  late DateTime start;
  late DateTime end;
  late int difference;
  late User user = User.fromMap({
    "id": 1,
    "email": "mking@workit.com",
    "username": "mking",
    "password": "Mking123",
    "fullName": "Martha King",
    "administrator": false,
    "totalDaysOff": 0.0,
    "managedProjects": [
      {
        "id": 1,
        "title": "Project 1",
        "description": "This project is a test.",
        "estimatedHours": 15.5,
        "totalHours": 4.0,
        "collaborators": [],
        "tasks": []
      }
    ],
    "collaboratedProjects": [],
    "createdTasks": [],
    "createdTodos": [],
    "shiftConfiguration": null,
    "daysOffDone": []
  });

  @override
  initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      start = args.value.startDate;
      end = args.value.endDate ?? args.value.startDate;
      difference = (end.difference(start).inHours / 24).round() + 1;
      //difference = end.difference(start).inDays;
    });
    print(difference);
  }

  Future<bool> getData() async {
    try {
      var response = await getDaysOffByUserId(user.id ?? 0);
      response.forEach((element) => daysOff.add(DaysOff.fromMap(element)));
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> sendDaysOff() async {
    DaysOff daysOff = DaysOff(
        concept: conceptController.text,
        startDatetime: start,
        endDatetime: end,
        totalDays: difference,
        user: user);
    var response = await createDaysOff(daysOff.toMap())
        .onError((error, stackTrace) => false);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    final DateFormat format = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder:
                    (BuildContext context, StateSetter secondSetState) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Define days off'),
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: conceptController,
                            ),
                            SizedBox(
                              height: media.height / 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    child: SfDateRangePicker(
                                  controller: dateController,
                                  onSelectionChanged: _onSelectionChanged,
                                  view: DateRangePickerView.month,
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  monthViewSettings:
                                      DateRangePickerMonthViewSettings(
                                          firstDayOfWeek: 1),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: secondaryColor),
                          )),
                      TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendDaysOff()
                                  .then((value) => Navigator.pop(context));
                            }
                          },
                          child: Text(
                            'Finish',
                            style: TextStyle(color: secondaryColor),
                          )),
                    ],
                  );
                });
              }).then((_) => setState(() {}));
        },
        backgroundColor: secondaryColor,
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: Text('Days off', style: TextStyle(color: kGrey5)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: kGrey4,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Total days: ',
                          style: TextStyle(fontSize: media.height / 40)),
                      Text(
                        '22',
                        style: TextStyle(fontSize: media.height / 30),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.height / 25,
                  ),
                  Row(
                    children: [
                      Text('Days left: ',
                          style: TextStyle(fontSize: media.height / 40)),
                      Text(
                        '11.5',
                        style: TextStyle(
                            fontSize: media.height / 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.height / 15,
                  ),
                  Text('Log', style: TextStyle(fontSize: media.height / 40)),
                  Container(
                    height: media.height / 3,
                    child: ListView.builder(
                        itemCount: daysOff.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              children: [
                                Text(format
                                    .format(daysOff[index].startDatetime)),
                                Text(' - '),
                                Text(format.format(daysOff[index].endDatetime))
                              ],
                            ),
                            //title: Text(daysOff[index].concept ?? '-'),
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              print(snapshot.stackTrace);
              return Center(child: Text('There has been an error'));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
