import 'package:dependencies/dependencies.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/usecases/usecase.dart';
import 'state.dart';

class TaskCubit extends Cubit<TaskState> {
  final ICreateTaskUsecase _createTaskUsecase;
  final IGetList _getListUsecase;

  TaskCubit({
    required ICreateTaskUsecase createTaskUsecase,
    required IGetList getList,
  })  : _createTaskUsecase = createTaskUsecase,
        _getListUsecase = getList,
        super(InitialState());

  Future<void> createTask({required TaskEntity task}) async {
    final data = await _getListUsecase()
      ..add(task);

    _createTaskUsecase(task: data);
  }

  Future<void> loadTaskList() async {
    emit(LoadTaskState());
    final data = await _getListUsecase();

    emit(
      data.isNotEmpty ? TaskListState(data) : EmptyTaskState(),
    );
  }

  Future<void> removeTask({required TaskEntity task}) async {
    emit(LoadTaskState());
    final data = await _getListUsecase()
      ..removeWhere(
        (element) =>
            element.description == task.description &&
            element.title == task.title &&
            element.dueDate == task.dueDate,
      );

    _createTaskUsecase(task: data);

    emit(
      data.isNotEmpty ? TaskListState(data) : EmptyTaskState(),
    );
  }

  Future<void> updateStatus({required TaskEntity task}) async {
    final data = await _getListUsecase();

    final index = data.indexWhere(
      (data) =>
          data.title == task.title &&
          data.description == task.description &&
          data.dueDate == task.dueDate,
    );

    if (index > -1) {
      data[index] = task;
      _createTaskUsecase(task: data);
    }

    emit(
      TaskListState(data),
    );
  }
}
