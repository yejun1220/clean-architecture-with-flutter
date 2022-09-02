import 'package:clean_architecture/stock_app/domain/repository/stock_repository.dart';
import 'package:clean_architecture/stock_app/presentation/company_listings/company_listings_state.dart';
import 'package:flutter/material.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = CompanyListingsState();

  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (companies) {
        _state.copyWith(companies: companies);
      },
      error: (e) {
        print('리모트 에러: ' + e.toString());
      },
    );

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }
}
