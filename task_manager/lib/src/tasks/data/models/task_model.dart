import 'dart:convert';

import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.description,
    required super.dueDate,
    required super.title,
    required super.status,
  });

  factory TaskModel.fromEntity(TaskEntity entity) => TaskModel(
        description: entity.description,
        dueDate: entity.dueDate,
        title: entity.title,
        status: entity.status,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'dueDate': dueDate.millisecondsSinceEpoch,
        'status': status,
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
        status: map['status'] as bool,
      );

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  TaskEntity toEntity() => TaskEntity(
        description: description,
        dueDate: dueDate,
        title: title,
        status: status,
      );
}
