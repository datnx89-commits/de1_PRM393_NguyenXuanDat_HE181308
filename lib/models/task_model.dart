class TaskModel {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final String iconName;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.iconName = 'laptop',
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? iconName,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      iconName: iconName ?? this.iconName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'icon_name': iconName,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isCompleted: (map['is_completed'] as int? ?? 0) == 1,
      iconName: map['icon_name'] as String? ?? 'laptop',
    );
  }
}
