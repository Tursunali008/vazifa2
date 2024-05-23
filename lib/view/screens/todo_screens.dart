import 'package:flutter/material.dart';
import 'package:vazifa2/controllers/controller.dart';

class TodoScreens extends StatefulWidget {
  const TodoScreens({super.key});

  @override
  State<TodoScreens> createState() => _TodoScreensState();
}

class _TodoScreensState extends State<TodoScreens> {
  final TaskController _taskController = TaskController();
  final TextEditingController _taskControllerText = TextEditingController();

  void _addTask() {
    if (_taskControllerText.text.isNotEmpty) {
      setState(() {
        _taskController.addTask(_taskControllerText.text);
        _taskControllerText.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _taskController.deleteTask(index);
    });
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _taskController.toggleTaskStatus(index);
    });
  }

  void _updateTask(int index, String title) {
    setState(() {
      _taskController.updateTask(index, title);
    });
  }

  void _showEditTaskDialog(int index) {
    final TextEditingController editController = TextEditingController(
      text: _taskController.tasks[index].title,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Update task title',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateTask(index, editController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskControllerText,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _taskController.tasks.length,
              itemBuilder: (context, index) {
                final task = _taskController.tasks[index];
                return Dismissible(
                  key: Key(task.title),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      _deleteTask(index);
                    } else if (direction == DismissDirection.endToStart) {
                      _showEditTaskDialog(index);
                    }
                  },
                  child: CheckboxListTile(
                    title: Text(task.title),
                    value: task.isCompleted,
                    onChanged: (value) {
                      _toggleTaskStatus(index);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Completed: ${_taskController.completedTasksCount}'),
                Text('Pending: ${_taskController.pendingTasksCount}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
