import 'dart:async';
import 'dart:developer';

import 'package:clean_architecture/stock_app/domain/repository/stock_repository.dart';
import 'package:clean_architecture/stock_app/presentation/company_info/company_info_event.dart';
import 'package:clean_architecture/stock_app/presentation/company_info/company_info_state.dart';
import 'package:flutter/material.dart';

class CompanyInfoViewModel with ChangeNotifier {
  final StockRepository _repository;

  var _state = const CompanyInfoState();

  CompanyInfoViewModel(this._repository, String symbol) {
    _loadCompanyInfo(symbol);
  }

  CompanyInfoState get state => _state;

  void onEvent(CompanyInfoEvent event) {
    event.when(
      loadCompanyInfo: _loadCompanyInfo,
    );
  }

  Future<void> _loadCompanyInfo(String symbol) async {
    _state = _state.copyWith(isLoading: true);
    final result = await _repository.getCompanyInfo(symbol);

    result.when(
      success: (companyInfo) {
        _state = _state.copyWith(
          companyInfo: companyInfo,
          errorMessage: null,
        );
      },
      error: (e) {
        _state = _state.copyWith(
          errorMessage: e.toString(),
        );
      },
    );

    final intraInfo = await _repository.getIntradayInfo(symbol);

    intraInfo.when(
      success: (intraInfo) {
        _state = _state.copyWith(
          stockInfo: intraInfo,
          isLoading: false,
          errorMessage: null,
        );
      },
      error: (e) {
        _state = _state.copyWith(
          stockInfo: [],
          isLoading: false,
          errorMessage: e.toString(),
        );
      },
    );
    notifyListeners();
  }
}
