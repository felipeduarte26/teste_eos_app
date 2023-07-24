import 'package:commons/commons.dart';

import 'tasks/data/datasources/local/task_datasource.dart';
import 'tasks/data/repositories/task_repository.dart';
import 'tasks/domain/repositories/task_repository_interface.dart';
import 'tasks/domain/usecases/usecase.dart';
import 'tasks/presentation/shared/cubit/cubit.dart';

void taskManagerInitialize() {
  getIt.registerFactory<ILocalStorage>(
    LocalStorage.new,
  );

  getIt.registerSingleton<ITaskDataSource>(
    TaskDatasource(
      storage: getIt.get<ILocalStorage>(),
    ),
  );

  getIt.registerSingleton<ITaskRepository>(
    TaskRepository(
      datasource: getIt.get<ITaskDataSource>(),
    ),
  );

  getIt.registerSingleton<ICreateTaskUsecase>(
    CreateTaskUsecase(
      repository: getIt.get<ITaskRepository>(),
    ),
  );

  getIt.registerSingleton<IGetList>(
    GetList(
      repository: getIt.get<ITaskRepository>(),
    ),
  );

  getIt.registerFactory(
    () => TaskCubit(
      createTaskUsecase: getIt.get<ICreateTaskUsecase>(),
      getList: getIt.get<IGetList>(),
    ),
  );
}
