import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stackedapipractice/ui/home/homeview_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => HomeViewMoel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home View"),
            ),
            body: SafeArea(
                child: Column(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.navigateToTaskView();
                    },
                    child: const Text("View Tasks"),
                  ),
                )
              ],
            )),
          );
        });
  }
}
