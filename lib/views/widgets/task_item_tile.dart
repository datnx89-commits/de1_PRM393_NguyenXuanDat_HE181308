import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskItemTile extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;
  final ValueChanged<bool>? onToggleComplete;

  const TaskItemTile({
    super.key,
    required this.task,
    required this.onEdit,
    this.onToggleComplete,
  });

  IconData _getLeadingIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'laptop':
      case 'computer':
        return Icons.laptop_chromebook;
      case 'book':
        return Icons.menu_book_outlined;
      case 'presentation':
        return Icons.co_present_outlined;
      case 'document':
      case 'note':
        return Icons.description_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading icon matching design
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getLeadingIcon(task.iconName),
              size: 24,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 14),

          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        task.description,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Colors.black54,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Optional completed check badge
          if (task.isCompleted) ...[
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Xong',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],

          // Trailing Edit button
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 22, color: Colors.black87),
            onPressed: onEdit,
            tooltip: 'Chỉnh sửa',
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
