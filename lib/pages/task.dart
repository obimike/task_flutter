// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task/pages/add_task.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/utils/db_helper.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  // All journals
  List<Map<String, dynamic>> _filteredData = [];
  List<Map<String, dynamic>> _data = [];

  // This function is used to fetch all data from the database
  void _refreshTasks() async {
    debugPrint("----------_refreshTasks-----------");
    final data = await SQLHelper.getItems();
    debugPrint(data.toString());
    setState(() {
      _data = data;
      _filteredData = data;
    });
    debugPrint(data.toString());
  }

  Future<void> _deleteTask(int id) async {
    final result = await SQLHelper.deleteItem(id);
    if (result > 0) {
      _refreshTasks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully deleted a task!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to delet this task!'),
        ),
      );
    }
  }

  @override
  void initState() {
    debugPrint("----------initState-----------");
    super.initState();
    _refreshTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  // This function is called whenever the text field changes
  void _filterData(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _data;
    } else {
      results = _data
          .where((data) => data["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _filteredData = results;
    });
  }

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
                            "Good day, you have 4 task yet to be completed.",
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (String keyword) {
                          _filterData(keyword);
                        },
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
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
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF27272C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                // child: _isLoading
                //     ? const Center(
                //         child: CircularProgressIndicator(),
                //       )
                //     : ListView.builder(
                //         itemCount: _filteredData.length,
                //         itemBuilder: (context, index) => Card(
                //           color: Colors.orange[200],
                //           margin: const EdgeInsets.all(15),
                //           child: ListTile(
                //               title: Text(_filteredData[index]['title']),
                //               trailing: SizedBox(
                //                 width: 100,
                //                 child: Row(
                //                   children: [
                //                     IconButton(
                //                       icon: const Icon(Icons.edit),
                //                       onPressed: () {},
                //                     ),
                //                     IconButton(
                //                       icon: const Icon(Icons.delete),
                //                       onPressed: () => _deleteTask(
                //                           _filteredData[index]['id']),
                //                     ),
                //                   ],
                //                 ),
                //               )),
                //         ),
                //       ),

                child: _filteredData.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredData.length,
                        itemBuilder: (BuildContext context, int index) {
                          // return TaskItem(
                          //     tasks: _filteredData, deleteTask: _deleteTask);
                          return TaskItem(
                              id: _filteredData[index]['id'],
                              taskTitle: _filteredData[index]['title'],
                              isChecked: _filteredData[index]['isDone'],
                              dateStamp: _filteredData[index]['createdAt'],
                              priority: _filteredData[index]['priority'],
                              tasks: _filteredData,
                              deleteTask: _deleteTask);
                        },
                      )
                    : const Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(fontSize: 24, color: Colors.white70),
                        ),
                      ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTask(refreshTasks: _refreshTasks)),
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
  final int id;
  final String taskTitle;
  String isChecked;
  String dateStamp;
  String priority;

  List<Map<String, dynamic>> tasks;
  Function deleteTask;

  TaskItem({
    super.key,
    required this.id,
    required this.taskTitle,
    required this.isChecked,
    required this.dateStamp,
    required this.priority,
    required this.tasks,
    required this.deleteTask,
  });

  @override
  State<TaskItem> createState() => _TaskItem();
}

class _TaskItem extends State<TaskItem> {
  void toggleCheckbox(bool value, int id) async {
    if (value) {
      setState(() {
        widget.isChecked = "true";
      });
      debugPrint("$value");
      final updateTask = await SQLHelper.updateItem(id, "true");
      if (updateTask >= 1) {
        _showToast("💪 Task is completed. Well Done 💪");
      }
    } else {
      setState(() {
        widget.isChecked = "false";
      });
      debugPrint("$value");
      final updateTask = await SQLHelper.updateItem(id, "false");
      if (updateTask >= 1) {
        _showToast("Task is undone.");
      }
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
                value: widget.isChecked == "true" ? true : false,
                onChanged: (value) => toggleCheckbox(value!, widget.id),
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
                          color: widget.isChecked == "true"
                              ? Colors.white24
                              : Colors.white,
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
              // onPressed: () {
              //   debugPrint("delete clicked ${widget.id}");
              //   _showAlertDialog(context, widget.id);
              // },
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Delete Alert',
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text(
                    'Do you wish to delete task? \n \n"${widget.taskTitle}"',
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'No'),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Yes');
                        widget.deleteTask(widget.id);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ),
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
