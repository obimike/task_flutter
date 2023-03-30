import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:task/utils/db_helper.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();

  static const items = [
    'High',
    'Medium',
    'Low',
  ];

  // Initial Selected Value
  String dropdownvalue = items[0];

  addNewTask() async {
    debugPrint(_titleController.text);
    if (_titleController.text.isEmpty) {
      debugPrint("Title can not be empty");
    } else {
      debugPrint(_titleController.text);
      final data = await SQLHelper.createItem(
          _titleController.text,
          "false",
          dropdownvalue,
          DateFormat('dd/M/yy - h:mma').format(DateTime.now()).toString());
      debugPrint(data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 36),
                    child: Text(
                      "Add new task",
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
                padding: const EdgeInsets.all(36),
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Task Title",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    TextField(
                      controller: _titleController,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Task Title",
                        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Task Priority",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                          ),
                          maxLines: 4,
                        ),
                      ],
                    ),
                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(8),
                      value: dropdownvalue,
                      dropdownColor: Colors.white,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownvalue = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 48.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      onPressed: () {
                        debugPrint("Button");
                        addNewTask();
                      },
                      child: const Text(
                        "Add Task",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
