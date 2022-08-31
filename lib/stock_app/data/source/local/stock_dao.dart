import 'package:clean_architecture/stock_app/data/source/local/company_listing_entity.dart';
import 'package:hive/hive.dart';

class StockDao {
  static const companyListing = 'companyListing';
  final box = Hive.box('stock.db');

  // 추가
  Future<void> insertCompanyListings(List<CompanyListingEntity> companyListingEntity) async {
    await box.put(StockDao.companyListing, companyListingEntity);
  }

  // 캐시 클리어
  Future<void> clearCompanyListings() async {
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final List<CompanyListingEntity> companyListing = await box.get(StockDao.companyListing, defaultValue: []);
    return companyListing.where((e) => e.name.toLowerCase().contains(query.toLowerCase()) || query.toUpperCase() == e.symbol).toList();
  }
}
