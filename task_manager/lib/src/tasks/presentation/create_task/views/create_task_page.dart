import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/task_entity.dart';
import '../../presentation.dart';
import '../../shared/cubit/cubit.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final cubit = getIt.get<TaskCubit>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          hintText: 'Informe o título da tarefa',
                          controller: _titleController,
                          labelText: 'Título',
                          validator: (String? value) {
                            if (value == null) {
                              return 'Informe o Título';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomFormField(
                          hintText: 'Informe a descrição da tarefa',
                          validator: (String? value) {
                            if (value == null) {
                              return 'Informe a Descrição';
                            }
                            return null;
                          },
                          controller: _descriptionController,
                          labelText: 'Descrição',
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Data de Vencimento'),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 3.5,
                          width: MediaQuery.sizeOf(context).width,
                          child: CustomScrollDatePicker(
                            onDateTimeChanged: (date) => _selectedDate = date,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 24,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _descriptionController.text.isNotEmpty &&
                              _titleController.text.isNotEmpty) {
                            cubit.createTask(
                              task: TaskEntity(
                                description: _descriptionController.text,
                                dueDate: _selectedDate,
                                title: _titleController.text,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Salvar'),
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
