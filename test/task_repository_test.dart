import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:de1/models/task_model.dart';
import 'package:de1/data/database/database_helper.dart';
import 'package:de1/data/repositories/task_repository.dart';

void main() {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('DatabaseHelper and TaskRepository CRUD operations work properly', () async {
    final testDb = DatabaseHelper.forTest(dbName: 'test_tasks.db');
    final repo = TaskRepository(dbHelper: testDb);
    
    // Add a specific test task
    final testTask = TaskModel(
      title: 'Bài tập kiểm thử',
      description: 'Mô tả kiểm thử',
      isCompleted: false,
      iconName: 'laptop',
    );
    final id = await repo.addTask(testTask);
    expect(id > 0, true);

    // Fetch by id
    final fetched = await repo.getTask(id);
    expect(fetched, isNotNull);
    expect(fetched!.title, 'Bài tập kiểm thử');
    expect(fetched.description, 'Mô tả kiểm thử');
    expect(fetched.isCompleted, false);

    // Update the task (matching Screen 2 requirement)
    final updated = fetched.copyWith(
      title: 'Bài tập kiểm thử (Đã sửa)',
      description: 'Đã hoàn thành kiểm thử',
      isCompleted: true,
    );
    await repo.updateTask(updated);

    final refetched = await repo.getTask(id);
    expect(refetched!.title, 'Bài tập kiểm thử (Đã sửa)');
    expect(refetched.description, 'Đã hoàn thành kiểm thử');
    expect(refetched.isCompleted, true);

    // Delete the task
    await repo.deleteTask(id);
    final deleted = await repo.getTask(id);
    expect(deleted, isNull);
  });
}
