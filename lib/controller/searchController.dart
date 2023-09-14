import 'package:flutter/material.dart';

class searchController extends ChangeNotifier {
  bool _searchbarVisible = false;
  bool _searchButtonVisible = true;

  onVisibilityChange() {
    _searchbarVisible = !_searchbarVisible;
    _searchButtonVisible = !_searchButtonVisible;
    notifyListeners();
  }

  get searchBarVisibility {
    return _searchbarVisible;
  }

  get searchButtonVisisbility {
    return _searchButtonVisible;
  }
}
