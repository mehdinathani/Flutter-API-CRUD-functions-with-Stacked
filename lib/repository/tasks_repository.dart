import 'dart:developer';

import 'package:stackedapipractice/data/api_client.dart';
import 'package:stackedapipractice/models/tasks_model.dart';

class TasksRepository {
  final _apiClient = ApiClient();
  final endpoint = "unicorns";

  Future<List<TasksModel>> getTasks() async {
    List<TasksModel> tasks = [];
    List<dynamic> tasksResponse = await _apiClient.get(endpoint);
    log(
      tasksResponse.toString(),
    );
    for (var i in tasksResponse) {
      tasks.add(TasksModel.fromJson(i));
    }
    log(tasks.toString());
    return tasks;
  }

  Future<TasksModel> createTask(Map<String, dynamic> task) async {
    // List<TasksModel> taskdata = [];
    // List<dynamic> taskData = task.toJson();
    // final response = await _apiClient.post(endpoint, taskData);
    // final updateTask = TasksModel.fromJson(response);

    final tasksResponse = await _apiClient.post(endpoint, task);
    // for (var i in tasksResponse) {
    //   task.add(TasksModel.fromJson(i));
    // }
    return TasksModel.fromJson(tasksResponse);
  }

  Future<TasksModel> updateTask(Map<String, dynamic> task, String id) async {
    final tasksResponse = await _apiClient.put(endpoint, task, id);

    return TasksModel.fromJson(tasksResponse);
  }

  Future<void> deleteTask(String taskID) async {
    await _apiClient.delete(endpoint, taskID);
  }
}
