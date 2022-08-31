import 'package:clean_architecture/stock_app/data/source/local/stock_dao.dart';
import 'package:clean_architecture/stock_app/data/source/remote/stock_api.dart';
import 'package:clean_architecture/stock_app/domain/model/company_listing.dart';
import 'package:clean_architecture/stock_app/domain/repository/stock_repository.dart';
import 'package:clean_architecture/stock_app/util/result.dart';
import 'package:clean_architecture/stock_app/data/mapper/company_mapper.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _stockApi;
  final StockDao _stockDao;

  StockRepositoryImpl(this._stockApi, this._stockDao);

  @override
  Future<Result<List<CompanyListing>>> getCompanyListings(bool fetchFromRemote, String query) async {
    final localListings = await _stockDao.searchCompanyListing(query);

    final isDbEmpty = localListings.isEmpty && query.isEmpty;
    final loadFromCache = !isDbEmpty && !fetchFromRemote;

    // 캐시
    if (loadFromCache) {
      return Result.success(localListings.map((e) => e.toCompanyListing()).toList());
    }

    // 원격 API
    try {
      final remoteListings = await _stockApi.getCompanyListings();
      // TODO : csv 구현해야한다.
      return Result.success([]);
    } catch (e) {
      return Result.error(Exception('데이터 로드 실패'));
    }
  }
}
