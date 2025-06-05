import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list_flutter/data/task_dummy.dart';
import 'package:todo_list_flutter/models/task.dart';

class TaskProvider with ChangeNotifier {
  final Map<String, Task> _items = {...TASK_DUMMY};

  List<Task> get listAll {
    return [..._items.values];
  }

  int get amount {
    return _items.length;
  }

  void save(Task task) {
    if (task.id.trim().isNotEmpty &&
        _items.containsKey(task.id)) {
      _items.update(task.id, (_) =>
          Task(id: task.id, title: task.title, description: task.description)
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(id, () =>
          Task(id: id, title: task.title, description: task.description));
    }

    notifyListeners();
  }

  void delete(Task? task) {
    if (task != null && task.id != null) {
      _items.remove(task.id);

      notifyListeners();
    }
  }
}