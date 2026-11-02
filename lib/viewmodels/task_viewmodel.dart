import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/task_repository.dart';
import '../models/task_model.dart';

part 'task_viewmodel.g.dart';

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepository();
}

@riverpod
class TaskListViewModel extends _$TaskListViewModel {
  @override
  FutureOr<List<TaskModel>> build() async {
    final repo = ref.watch(taskRepositoryProvider);
    return await repo.getTasks();
  }

  Future<void> refreshTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(taskRepositoryProvider);
      return await repo.getTasks();
    });
  }

  Future<void> updateTask(TaskModel task) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.updateTask(task);
    await refreshTasks();
  }

  Future<void> addTask(TaskModel task) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.addTask(task);
    await refreshTasks();
  }

  Future<void> deleteTask(int id) async {
    final repo = ref.read(taskRepositoryProvider);
    await repo.deleteTask(id);
    await refreshTasks();
  }
}
