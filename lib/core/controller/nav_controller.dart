// ignore_for_file: prefer_final_fields

import 'package:nodes/config/dynamic_page_routes.dart';
import 'package:nodes/core/controller/base_controller.dart';
import 'package:nodes/features/dashboard/screen/dashboard_wrapper.dart';
import 'package:nodes/utilities/utils/enums.dart';

class NavController extends BaseController {
  // ##################### VARIABLES #####################
  int _currentIndex = 0;
  bool _isFullyExpanded = false;
  List<String> _pageListStack = [DashboardWrapper.routeName];
  HorizontalSlidingCardDataSource _dashboardDynamicItem =
      HorizontalSlidingCardDataSource.Empty;

  // ##################### GETTERS #####################
  Map<String, dynamic> get persistentRoutes => persistentRoutesSettings;

  int get currentIndex => _currentIndex;
  bool get isFullyExpanded => _isFullyExpanded;
  List<String> get pageListStack => _pageListStack;
  // This gets the last FILO first in, Last out
  String get currentPageListStackItem => _pageListStack.last;
  HorizontalSlidingCardDataSource get currentDashboardDynamicItem =>
      _dashboardDynamicItem;

  // ##################### SETTERS #####################
  set currentIndexVal(int val) {
    _currentIndex = val;
    notifyListeners();
  }

  // Used to add screens to the stack
  updatePageListStack(String val) {
    _pageListStack.add(val);
    notifyListeners();
  }

  popPageListStack() {
    // This is used to remove all, except the first (index 0) item
    // Being the IndividualDashboardScreen
    if (_pageListStack.length > 1) {
      _pageListStack.removeLast();
      notifyListeners();
    }
  }

  // To be called when the home button is pressed...
  resetPageListStack() {
    _pageListStack = [
      DashboardWrapper.routeName,
    ];
    notifyListeners();
  }

  set fullyExpandedVal(bool val) {
    _isFullyExpanded = val;
    notifyListeners();
  }

  resetValues() {
    currentIndexVal = 0;
    fullyExpandedVal = false;
  }

  updateDashboardDynamicItem(HorizontalSlidingCardDataSource val) {
    _dashboardDynamicItem = val;
    notifyListeners();
  }
}
