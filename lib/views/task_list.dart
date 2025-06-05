import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/components/task_list_screen.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/routes/app_routes.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskProvider tasks = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.TASK_FORM);
            },
          )
        ]
      ),
      body: ListView.builder(
        itemCount: tasks.amount,
        itemBuilder: (ctx,i) => TaskListScreen(tasks.listAll.elementAt(i))
      )
    );
  }
}