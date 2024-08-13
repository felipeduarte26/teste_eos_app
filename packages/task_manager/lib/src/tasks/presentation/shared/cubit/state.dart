import 'package:dependencies/dependencies.dart';

import '../../../domain/entities/task_entity.dart';

sealed class TaskState extends Equatable {}

final class InitialState extends TaskState {
  @override
  List<Object?> get props => [];
}

final class LoadTaskState extends TaskState {
  @override
  List<Object?> get props => [];
}

final class EmptyTaskState extends TaskState {
  @override
  List<Object?> get props => [];
}

final class TaskListState extends TaskState {
  final List<TaskEntity> data;

  TaskListState(this.data);
  @override
  List<Object?> get props => [data];
}

final class RemoveState extends TaskState {
  final List<TaskEntity> data;

  RemoveState(this.data);
  @override
  List<Object?> get props => [data];
}
