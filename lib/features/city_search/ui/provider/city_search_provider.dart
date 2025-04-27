import 'dart:async';

import 'package:flutter/material.dart';

import '../../domain/entitiy/city_model.dart';
import '../../domain/use_case/search_city_usecase.dart';

class CitySearchProvider extends ChangeNotifier {
  final SearchCityUseCase searchCityUseCase;

  CitySearchProvider({required this.searchCityUseCase});

  List<CityModel> _cities = [];
  bool _loading = false;
  String? _error;

  Timer? _debounce;

  List<CityModel> get cities => _cities;
  bool get isLoading => _loading;
  String? get error => _error;

  void onQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchCities(query);
    });
  }

  Future<void> _searchCities(String query) async {
    if (query.isEmpty) {
      _cities = [];
      notifyListeners();
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await searchCityUseCase.call(query);
      _cities = result;
    } catch (e) {
      _error = 'error_searching_cities';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void reset() {
    _cities = [];
    _loading = false;
    _error = null;
    _debounce?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
