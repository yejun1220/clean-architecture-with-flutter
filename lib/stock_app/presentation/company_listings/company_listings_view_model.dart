import 'dart:async';

import 'package:clean_architecture/stock_app/presentation/company_listings/company_listings_event.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/stock_app/domain/repository/stock_repository.dart';
import 'package:clean_architecture/stock_app/presentation/company_listings/company_listings_state.dart';

class CompanyListingsViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyListingsState();

  Timer? _debounce;

  CompanyListingsState get state => _state;

  CompanyListingsViewModel(this._repository) {
    _getCompanyListings();
  }

  void onEvent(CompanyListingsEvent event) {
    event.when(
      refreshCompanyListings: _refreshCompanyListings,
      onSearchQueryChange: _onSearchQueryChange,
    );
  }

  Future<void> _getCompanyListings({
    bool fetchFromRemote = false,
    String query = '',
  }) async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    final result = await _repository.getCompanyListings(fetchFromRemote, query);
    result.when(
      success: (listings) {
        _state = _state.copyWith(
          companies: listings,
        );
      },
      error: (e) {
        print('리모트 에러: ' + e.toString());
      },
    );

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  void _refreshCompanyListings() {
    _getCompanyListings(fetchFromRemote: true);
  }

  void _onSearchQueryChange(String query) {
    // debounce가 활성화 되어있으면(전에 onSearchQueryChange가 실행되었으면) debounce의 콜백함수가 실행되지 않는다.(cancel 한다.)
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _getCompanyListings(query: query);
    });
  }
}
