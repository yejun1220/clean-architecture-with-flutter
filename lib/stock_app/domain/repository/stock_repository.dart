import 'package:clean_architecture/stock_app/domain/model/company_listing.dart';
import 'package:clean_architecture/stock_app/util/result.dart';

abstract class StockRepository {
  Future<Result<List<CompanyListing>>> getCompanyListings(
    bool fetchFromRemote,
    String query,
  );
}
