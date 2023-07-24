import 'package:dependencies/dependencies.dart';

class TaskEntity extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool status;

  const TaskEntity({
    required this.description,
    required this.dueDate,
    required this.title,
    this.status = false,
  });

  TaskEntity copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    bool? status,
  }) =>
      TaskEntity(
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        title: title ?? this.title,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [title, description, dueDate, status];
}
