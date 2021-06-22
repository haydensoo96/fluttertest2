import 'dart:js';

import 'package:core_flutter/models/TaskModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoModel extends ChangeNotifier {

  List<TaskModel> taskList = [];

  addTaskList(title,details) {
    TaskModel taskModel = TaskModel("Title ${taskList[title]}",
        "this is the task detail ${taskList[details]}");
    taskList.add(taskModel);
    notifyListeners();
  }
}
