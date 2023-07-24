import 'package:commons/commons.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../../../route.dart';
import '../../../domain/entities/task_entity.dart';
import '../../shared/cubit/cubit.dart';

class HomeTasks extends StatefulWidget {
  const HomeTasks({super.key});

  @override
  State<HomeTasks> createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  final TaskCubit _cubit = getIt.get<TaskCubit>();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TaskCubit, TaskState>(
        bloc: _cubit..loadTaskList(),
        builder: (context, state) => switch (state) {
          LoadTaskState _ => const Center(child: CircularProgressIndicator()),
          EmptyTaskState _ => _buildScaffold(
              const Center(
                child: Text('<Você não tem Lista de Tarefas cadastradas>'),
              ),
            ),
          final TaskListState state => _buildBody(data: state.data),
          _ => const SizedBox.shrink(),
        },
      );

  Widget _buildBody({required List<TaskEntity> data}) => _buildScaffold(
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: data.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              trailing: Checkbox(
                value: data[index].status,
                onChanged: (value) async {
                  await _cubit.updateStatus(
                    task: data[index].copyWith(
                      status: value,
                    ),
                  );
                },
              ),
              leading: IconButton(
                onPressed: () async => _confirmDelete(data[index]),
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              title: Text(data[index].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].description,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Vencimento: ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(data[index].dueDate),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildScaffold(Widget body) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(
              TasksManagerRouter.create,
            );

            _cubit.loadTaskList();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('Lista de tarefas'),
        ),
        body: body,
      );

  Future<void> _confirmDelete(TaskEntity task) => showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) => Container(
          color: Colors.white,
          height: MediaQuery.sizeOf(context).height / 4,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 46,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Flexible(
                  child: Text(
                    'Você realmente deseja excluir essa tarefa?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 20,
                      child: ElevatedButton(
                        onPressed: () async {
                          _cubit.removeTask(
                            task: task,
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Sim'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
