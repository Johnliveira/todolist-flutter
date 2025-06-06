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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          _formData['id']?.isNotEmpty == true ? 'Editar Tarefa' : 'Nova Tarefa',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.save_rounded),
              iconSize: 24,
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Text(
                _formData['id']?.isNotEmpty == true
                    ? 'Modifique os dados da sua tarefa'
                    : 'Preencha os dados da nova tarefa',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: _formData['title'],
                          decoration: InputDecoration(
                            labelText: 'Título da Tarefa',
                            prefixIcon: Icon(Icons.title, color: Colors.blue.shade600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe o título da tarefa';
                            }
                            return null;
                          },
                          onSaved: (value) => _formData['title'] = value!,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: _formData['description'],
                          decoration: InputDecoration(
                            labelText: 'Descrição',
                            prefixIcon: Icon(Icons.description, color: Colors.blue.shade600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe a descrição da tarefa';
                            }
                            return null;
                          },
                          onSaved: (value) => _formData['description'] = value!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
