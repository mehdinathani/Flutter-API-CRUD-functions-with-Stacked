import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stackedapipractice/ui/tasks/tasksview_model.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.getTasks(),
      viewModelBuilder: () => TasksViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Tasks"),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                // Display tasks list
                if (!viewModel.isBusy && viewModel.tasks.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.tasks.length,
                      itemBuilder: (context, index) {
                        final task = viewModel.tasks[index];
                        return ListTile(
                          title: Text(task.name!),
                          trailing: IconButton(
                            onPressed: () {
                              viewModel.showBottomSheet(task);
                            },
                            icon: const Icon(Icons.update),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              viewModel.deleteTask(task.sId!);
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                        );
                      },
                    ),
                  ),

                // Display CircularProgressIndicator if viewModel is busy
                if (viewModel.isBusy)
                  Center(
                    child: CircularProgressIndicator(),
                  ),

                // Display "No Tasks Yet" message if viewModel is not busy and tasks list is empty
                if (!viewModel.isBusy && viewModel.tasks.isEmpty)
                  Center(
                    child: Text("No Tasks Yet"),
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.showAddTaskBottomSheet();
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
