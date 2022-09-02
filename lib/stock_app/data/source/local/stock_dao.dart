import 'package:clean_architecture/stock_app/data/source/local/company_listing_entity.dart';
import 'package:hive/hive.dart';

class StockDao {
  static const companyListing = 'companyListing';

  // 추가
  Future<void> insertCompanyListings(List<CompanyListingEntity> companyListingEntities) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.addAll(companyListingEntities);
  }

  // 캐시 클리어
  Future<void> clearCompanyListings() async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> searchCompanyListing(String query) async {
    final box = await Hive.openBox<CompanyListingEntity>('stock.db');
    final List<CompanyListingEntity> companyListing = box.values.toList();
    return companyListing.where((e) => e.name.toLowerCase().contains(query.toLowerCase()) || query.toUpperCase() == e.symbol).toList();
  }
}
