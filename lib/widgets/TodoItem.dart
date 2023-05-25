import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:workit/resources/api_calls.dart';
import 'package:workit/resources/constants.dart';

import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTaskChanged,
    required this.checkValue,
    required this.taskList,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTaskChanged;
  bool checkValue;
  List<Todo> taskList;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.title),
      onDismissed: (direction) {
        deleteTodo(todo.id);
        taskList.removeAt(taskList.indexOf(todo));
      },
      child: ListTile(
        onTap: () {
          onTaskChanged(todo);
        },
        leading: Checkbox(
          value: checkValue,
          onChanged: (bool? value) => onTaskChanged(todo),
          fillColor: MaterialStateProperty.all<Color>(kGrey5),
        ),
        title: Text(todo.title, style: _getTextStyle(todo.isChecked)),
      ),
    );
  }
}
