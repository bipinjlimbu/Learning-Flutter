import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [
    Todo(id: '1', title: 'Buy groceries', isCompleted: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return GestureDetector(
            onTap: () {
              createOrUpdateTodo(index, todo.title);
            },
            child: ListTile(
              title: Text(todo.title),
              trailing: Container(
                color: Colors.red,
                width: 100.0,
                height: 48.0,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          todos.removeAt(index);
                        });
                      },
                    ),
                    Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          todos[index] = Todo(
                            id: todo.id,
                            title: todo.title,
                            isCompleted: value ?? false,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createOrUpdateTodo(null, '');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void createOrUpdateTodo(int? index, String title) {
    final TextEditingController titleController = TextEditingController(
      text: title,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Create Todo' : 'Update Todo'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = titleController.text;
                if (newTitle.isNotEmpty) {
                  setState(() {
                    if (index == null) {
                      todos.add(
                        Todo(
                          id: DateTime.now().toString(),
                          title: newTitle,
                          isCompleted: false,
                        ),
                      );
                    } else {
                      todos[index] = todos[index].copyWith(title: newTitle);
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
