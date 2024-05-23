class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class TaskList {
  List<Task> tasks = [];

  void addTask(String title) {
    tasks.add(Task(title: title));
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
  }

  void updateTask(int index, String title) {
    tasks[index].title = title;
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
  }

  int get completedTasksCount {
    return tasks.where((task) => task.isCompleted).length;
  }

  int get pendingTasksCount {
    return tasks.length - completedTasksCount;
  }
}
