import 'package:clean_architecture/stock_app/data/repository/stock_repository_impl.dart';
import 'package:clean_architecture/stock_app/data/source/local/company_listing_entity.dart';
import 'package:clean_architecture/stock_app/data/source/local/stock_dao.dart';
import 'package:clean_architecture/stock_app/data/source/remote/stock_api.dart';
import 'package:clean_architecture/stock_app/presentation/company_listings/company_listings_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('company_listings_view_model 생성 시 데이터를 잘 가져와야 한다.', () async {
    Hive.init(null);
    Hive.registerAdapter(CompanyListingEntityAdapter());

    final _stockApi = StockApi();
    final _stockDao = StockDao();
    final viewModel = CompanyListingsViewModel(StockRepositoryImpl(_stockApi, _stockDao));

    await Future.delayed(const Duration(seconds: 2));
    expect(viewModel.state.companies.isNotEmpty, true);
  });
  
}