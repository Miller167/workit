import 'package:flutter/material.dart';
import 'package:workit/resources/api_calls.dart';
import 'package:workit/resources/constants.dart';
import '../models/todo.dart';
import '../widgets/TodoItem.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late List<Todo> _todos = [];
  final TextEditingController _textFieldController = TextEditingController();

  Future<dynamic> getData() async {
    _todos.clear();
    List resp = await getTodosByUserId(user.id ?? 0);
    resp.forEach((element) {
      _todos.add(Todo.fromMap(element));
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 40, 20, 20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: media.width / 15),
                child: Text('Today\'s To Do s!',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      print(snapshot.stackTrace);
                      return const Center(
                        child: Text(
                          'An error occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      return Container(
                        height: media.height / 1.3,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          children: _todos.map((Todo todo) {
                            return TodoItem(
                              todo: todo,
                              checkValue: todo.isChecked,
                              onTaskChanged: _handleTaskChange,
                              taskList: _todos,
                            );
                          }).toList(),
                        ),
                      );
                    }
                  }

                  // Displaying splash to indicate loading state
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },

                // Future that needs to be resolved
                // inorder to display something on the Canvas
                future: getData(),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: FloatingActionButton(
                onPressed: () => _displayDialog(),
                tooltip: 'Add Item',
                backgroundColor: secondaryColor,
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTaskItem(String title) async {
    Map map = {'title': title, 'isChecked': false, 'user': user.toMap()};

    var response = await createTodo(map);
    map['id'] = response['id'];
    Todo todo = Todo.fromMap(map);
    print(response);

    _textFieldController.clear();
  }

  void _handleTaskChange(Todo task) {
    setState(() {
      task.isChecked = !task.isChecked;
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add a new task',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: 'Type your new task',
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTaskItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
