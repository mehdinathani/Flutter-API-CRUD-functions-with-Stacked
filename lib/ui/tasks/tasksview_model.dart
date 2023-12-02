import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stackedapipractice/app/app.locator.dart';
import 'package:stackedapipractice/models/tasks_model.dart';
import 'package:stackedapipractice/repository/tasks_repository.dart';

class TasksViewModel extends BaseViewModel {
  final tasksRepository = TasksRepository();
  NavigationService navigationService = locator<NavigationService>();

  List<TasksModel> tasks = [];

  getTasks() async {
    setBusy(true);
    debugPrint("TaskviewModel");
    log(tasksRepository.getTasks().toString());
    tasks = await tasksRepository.getTasks();
    setBusy(false);
    rebuildUi();
  }

  Future<void> createTask(Map<String, dynamic> task) async {
    setBusy(true);
    await tasksRepository.createTask(task);
    await getTasks();
    setBusy(false);
    rebuildUi();
  }

  Future<void> updatedTask(
    String id,
    Map<String, dynamic> task,
  ) async {
    setBusy(true);
    await tasksRepository.updateTask(task, id);
    await getTasks();
    setBusy(false);
    rebuildUi();
  }

  Future<void> deleteTask(String taskID) async {
    setBusy(true);
    await tasksRepository.deleteTask(taskID);
    await getTasks();
    setBusy(false);
    rebuildUi();
  }

  void showBottomSheet(TasksModel task) {
    TextEditingController nameController =
        TextEditingController(text: task.name);
    TextEditingController ageController =
        TextEditingController(text: task.age.toString());
    TextEditingController colorController =
        TextEditingController(text: task.colour);

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: navigationService.navigatorKey!.currentContext!,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Update task with the new values from text fields
                  TasksModel updatedTaskData = TasksModel(
                    name: nameController.text,
                    age: int.tryParse(ageController.text) ?? 0,
                    colour: colorController.text,
                  );
                  var data = updatedTaskData.toJson();
                  // Call the updatedTask function with the task ID and updated task
                  await updatedTask(task.sId!, data);

                  // Close the bottom sheet
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showAddTaskBottomSheet() {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController colorController = TextEditingController();

    showModalBottomSheet(
      context: navigationService.navigatorKey!.currentContext!,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Create a new task with the values from text fields
                  final newTaskData = {
                    "name": nameController.text,
                    "age": int.tryParse(ageController.text) ?? 0,
                    "colour": colorController.text,
                  };

                  // TasksModel newTaskData = TasksModel(
                  //   name: nameController.text,
                  //   age: int.tryParse(ageController.text) ?? 0,
                  //   colour: colorController.text,
                  // );

                  // Call the createTask function to add the new task
                  await createTask(newTaskData);
                  rebuildUi();

                  // Close the bottom sheet
                  Navigator.pop(context);
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        );
      },
    );
  }
}
