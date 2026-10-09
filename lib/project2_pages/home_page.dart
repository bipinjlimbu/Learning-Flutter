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

  // Green & White Color Palette
  static const Color primaryDarkGreen = Color(0xFF1B4D3E);
  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFFA5D6A7);
  static const Color mintBackground = Color(0xFFF3F7F4);
  static const Color chipBackground = Color(0xFFE8F5E9);

  @override
  Widget build(BuildContext context) {
    final completedCount = todos.where((t) => t.isCompleted).length;

    return Scaffold(
      backgroundColor: mintBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryDarkGreen,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Daily Todos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              'Stay organized, stay productive',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Header Stats / Progress Summary Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            decoration: const BoxDecoration(
              color: primaryDarkGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.task_alt, color: lightGreen, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Task Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$completedCount / ${todos.length} Done',
                      style: const TextStyle(
                        color: primaryDarkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main List View or Empty State
          Expanded(
            child: todos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: chipBackground,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.assignment_turned_in_outlined,
                            size: 48,
                            color: primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'All Clear!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'You have no pending tasks today.\nTap + to add a new task.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: todo.isCompleted
                                ? Colors.transparent
                                : primaryGreen.withOpacity(0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16.0),
                            onTap: () {
                              createOrUpdateTodo(index, todo.title);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  // Custom Checkbox
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        todos[index] = Todo(
                                          id: todo.id,
                                          title: todo.title,
                                          isCompleted: !todo.isCompleted,
                                        );
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: todo.isCompleted
                                            ? primaryGreen
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: todo.isCompleted
                                              ? primaryGreen
                                              : Colors.grey.shade400,
                                          width: 2,
                                        ),
                                      ),
                                      child: todo.isCompleted
                                          ? const Icon(
                                              Icons.check,
                                              size: 18,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // Title & Status/Tap to Edit Chips
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          todo.title,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: todo.isCompleted
                                                ? Colors.grey.shade500
                                                : Colors.black87,
                                            decoration: todo.isCompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 4,
                                          children: [
                                            // Status Tag
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: todo.isCompleted
                                                    ? Colors.grey.shade100
                                                    : chipBackground,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                todo.isCompleted
                                                    ? 'Completed'
                                                    : 'In Progress',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: todo.isCompleted
                                                      ? Colors.grey
                                                      : primaryGreen,
                                                ),
                                              ),
                                            ),

                                            // "Tap to edit" Highlight Chip
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: primaryGreen.withOpacity(
                                                  0.08,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: primaryGreen
                                                      .withOpacity(0.2),
                                                  width: 0.8,
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.edit_outlined,
                                                    size: 11,
                                                    color: primaryDarkGreen,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    'Tap to edit',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: primaryDarkGreen,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Delete Icon Button
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.redAccent,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        todos.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          createOrUpdateTodo(null, '');
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'New Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: chipBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  index == null ? Icons.add_task : Icons.edit_note,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                index == null ? 'Create Todo' : 'Update Todo',
                style: const TextStyle(
                  color: primaryDarkGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                autofocus: true,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'e.g., Complete Flutter Project',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                  labelStyle: const TextStyle(color: primaryGreen),
                  prefixIcon: const Icon(
                    Icons.notes_rounded,
                    color: primaryGreen,
                  ),
                  filled: true,
                  fillColor: mintBackground,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: primaryGreen,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
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
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
