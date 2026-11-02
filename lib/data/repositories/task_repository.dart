import '../../models/task_model.dart';
import '../database/database_helper.dart';

class TaskRepository {
  final DatabaseHelper _dbHelper;

  TaskRepository({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<List<TaskModel>> getTasks() => _dbHelper.getAllTasks();

  Future<TaskModel?> getTask(int id) => _dbHelper.getTaskById(id);

  Future<int> addTask(TaskModel task) => _dbHelper.insertTask(task);

  Future<int> updateTask(TaskModel task) => _dbHelper.updateTask(task);

  Future<int> deleteTask(int id) => _dbHelper.deleteTask(id);
}
