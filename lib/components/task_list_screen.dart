import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';
import 'package:todo_list_flutter/routes/app_routes.dart';

class TaskListScreen extends StatelessWidget {
  final Task task;
  
  const TaskListScreen(this.task);
  
  @override
  Widget build(BuildContext context) {
    final image = CircleAvatar(backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2021/11/06/16/56/meeting-point-6773800_1280.png'));
    return ListTile(
      leading: image,
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.orange,
              onPressed: (){
                Navigator.of(context).pushNamed(
                  AppRoutes.TASK_FORM, arguments: task,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Tarefa'),
                    content: const Text('A tarefa será excluída permanentemente!'),
                    actions: <Widget> [
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ]
                  )
                ).then((confirm) {
                  if (confirm) {
                    Provider.of<TaskProvider>(context, listen: false).delete(task);
                  }
                });
              },
            )
          ],
        ),
      )
    );
  }
}