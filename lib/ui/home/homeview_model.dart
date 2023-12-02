import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stackedapipractice/app/app.locator.dart';
import 'package:stackedapipractice/app/app.router.dart';

class HomeViewMoel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();

  navigateToTaskView() {
    navigationService.navigateToTasksView();
  }
}
