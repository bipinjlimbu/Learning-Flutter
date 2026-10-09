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
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Checkbox(
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
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTodoTitle = '';
              return Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 16.0,
                      children: [
                        const Text(
                          'Add New Todo',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          onChanged: (value) {
                            newTodoTitle = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Todo Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            if (newTodoTitle.isNotEmpty) {
                              setState(() {
                                todos.add(
                                  Todo(
                                    id: DateTime.now().toString(),
                                    title: newTodoTitle,
                                    isCompleted: false,
                                  ),
                                );
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
