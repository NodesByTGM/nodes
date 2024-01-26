


import 'package:nodes/core/controller/base_controller.dart';

class NavController extends BaseController {
  int _currentIndex = 0;
  int _createFacilityCurrentIndex = 0;
  bool _isFullyExpanded = false;

  int get currentIndex => _currentIndex;
  int get createFacilityCurrentIndex => _createFacilityCurrentIndex;
  bool get isFullyExpanded => _isFullyExpanded;


  set currentIndexVal(int val) {
    _currentIndex = val;
    notifyListeners();
  }
  set currentFacilityIndexVal(int val) {
    _createFacilityCurrentIndex = val;
    notifyListeners();
  }

  set fullyExpandedVal(bool val) {
    _isFullyExpanded = val;
    notifyListeners();
  }

  resetValues() {
    currentIndexVal  = 0;
    fullyExpandedVal  = false;
  }
}
