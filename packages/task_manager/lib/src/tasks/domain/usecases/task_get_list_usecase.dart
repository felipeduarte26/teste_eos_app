import '../entities/task_entity.dart';
import '../repositories/task_repository_interface.dart';

abstract interface class IGetList {
  Future<List<TaskEntity>> call();
}

final class GetList implements IGetList {
  final ITaskRepository _repository;

  GetList({required ITaskRepository repository}) : _repository = repository;

  @override
  Future<List<TaskEntity>> call() async {
    final data = await _repository.getList();
    data.sort(
      (a, b) => a.dueDate.compareTo(b.dueDate),
    );
    return data;
  }
}
