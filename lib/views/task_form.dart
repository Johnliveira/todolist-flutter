import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter/models/task.dart';
import 'package:todo_list_flutter/provider/task_provider.dart';

class TaskForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  TaskForm({super.key});

  void _loadTask(Task task) {
    _formData['id'] = task.id ?? '';
    _formData['title'] = task.title ?? '';
    _formData['description'] = task.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Task task = ModalRoute.of(context)!.settings.arguments as Task;
      _loadTask(task);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Tarefa'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                TaskProvider taskProvider = Provider.of<TaskProvider>(
                  context,
                  listen: false,
                );
                taskProvider.save(
                  Task(
                    id: _formData['id'] ?? '',
                    title: _formData['title']!,
                    description: _formData['description']!,
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['title'],
                decoration: const InputDecoration(labelText: 'Título:'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o título da tarefa';
                  }
                  return null;
                },
                onSaved: (value) => _formData['title'] = value!,
              ),
              TextFormField(
                initialValue: _formData['description'],
                decoration: const InputDecoration(labelText: 'Descrição:'),
                onSaved: (value) => _formData['description'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
