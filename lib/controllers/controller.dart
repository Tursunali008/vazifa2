
import 'package:vazifa2/models/task.dart';

class TaskController {
  TaskList taskList = TaskList();

  List<Task> get tasks => taskList.tasks;

  void addTask(String title) {
    taskList.addTask(title);
  }

  void deleteTask(int index) {
    taskList.deleteTask(index);
  }

  void updateTask(int index, String title) {
    taskList.updateTask(index, title);
  }

  void toggleTaskStatus(int index) {
    taskList.toggleTaskStatus(index);
  }

  int get completedTasksCount {
    return taskList.completedTasksCount;
  }

  int get pendingTasksCount {
    return taskList.pendingTasksCount;
  }
}
