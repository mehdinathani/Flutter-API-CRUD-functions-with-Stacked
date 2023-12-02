import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stackedapipractice/ui/home/home_view.dart';
import 'package:stackedapipractice/ui/tasks/tasks_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: TasksView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {}
