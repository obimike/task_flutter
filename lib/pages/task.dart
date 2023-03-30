import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/pages/add_task.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            "Good day, you have 4 task yet to be complete.",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: TextField(
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Search Tasks",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 18),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Text(
                            "Task Progress",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        value:
                            0.75, // Set a value between 0.0 and 1.0 to indicate progress
                        backgroundColor: Colors
                            .white, // Set the background color of the progress bar
                        valueColor: AlwaysStoppedAnimation<Color>(Color(
                            0xFF27272C)), // Set the color of the progress bar
                      ),
                    ),
                    const Text(
                      "(75%)",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF27272C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 32),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "All Tasks",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TaskItem(
                        taskTitle:
                            "Top 3 Ways to Give Flutter Widget Size in Percentage (2023)",
                        isChecked: true,
                        dateStamp: DateFormat('dd/M/yy - h:mma')
                            .format(DateTime.now())
                            .toString(),
                        priority: "Medium"),
                    TaskItem(
                        taskTitle:
                            "how to pass a parameter to other stateful widget in flutter",
                        isChecked: false,
                        dateStamp: DateFormat('dd/M/yy - h:mma')
                            .format(DateTime.now())
                            .toString(),
                        priority: "High"),
                    TaskItem(
                        taskTitle: "Kickstart your career",
                        isChecked: true,
                        dateStamp: DateFormat('dd/M/yy - h:mma')
                            .format(DateTime.now())
                            .toString(),
                        priority: "Low"),
                    TaskItem(
                        taskTitle:
                            "Flutter/Dart: Pass Parameters to a Stateful Widget?",
                        isChecked: false,
                        dateStamp: DateFormat('dd/M/yy - h:mma')
                            .format(DateTime.now())
                            .toString(),
                        priority: "Medium"),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTask()),
            );
          },
          backgroundColor: Colors.white,
          elevation: 8,
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  final String taskTitle;
  bool isChecked;
  String dateStamp;
  String priority;

  TaskItem(
      {super.key,
      required this.taskTitle,
      required this.isChecked,
      required this.dateStamp,
      required this.priority});

  @override
  State<TaskItem> createState() => _TaskItem();
}

class _TaskItem extends State<TaskItem> {
  // static get isChecked => null;

  void toggleCheckbox(bool value) {
    if (value) {
      setState(() {
        widget.isChecked = true;
      });
      debugPrint("$value");
      _showToast("💪 Task is completed. Well Done 💪");
    } else {
      setState(() {
        widget.isChecked = false;
      });
      debugPrint("$value");
      _showToast("Task is undone.");
    }
  }

  Color _setTextColor() {
    Color textColor;
    if (widget.priority == "High") {
      textColor = Colors.red;
    } else if (widget.priority == "Medium") {
      textColor = Colors.yellow;
    } else {
      textColor = Colors.green;
    }

    return textColor;
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CheckboxTheme(
              data: CheckboxThemeData(
                checkColor:
                    MaterialStateColor.resolveWith((states) => Colors.black),
                fillColor:
                    MaterialStateColor.resolveWith((states) => Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              child: Checkbox(
                value: widget.isChecked,
                onChanged: (value) => toggleCheckbox(value!),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.taskTitle,
                        style: TextStyle(
                          color:
                              widget.isChecked ? Colors.white24 : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.priority,
                        style: TextStyle(
                          fontSize: 12,
                          color: _setTextColor(),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          letterSpacing: -0.24,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          widget.dateStamp,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.green)),
              onPressed: () {
                debugPrint("delete clicked");
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[800],
              ),
            ),
          )
        ],
      ),
    );
  }
}
