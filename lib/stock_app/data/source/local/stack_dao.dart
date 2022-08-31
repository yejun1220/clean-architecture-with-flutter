import 'package:clean_architecture/stock_app/data/source/local/company_listing_entity.dart';
import 'package:hive/hive.dart';

class StackDao {
  static const companyListing = 'companyListing';
  final box = Hive.box('stock.db');

  // 추가
  Future<void> insertCompanyListings(List<CompanyListingEntity> companyListingEntity) async {
    await box.put(StackDao.companyListing, companyListingEntity);
  }

  // 캐시 클리어
  Future<void> clearCompanyListings() async {
    await box.clear();
  }

  // 검색
  Future<List<CompanyListingEntity>> search(String query) async {
    final List<CompanyListingEntity> companyListing = await box.get(StackDao.companyListing, defaultValue: []);
    return companyListing.where((e) => e.name.toLowerCase().contains(query.toLowerCase()) || query.toUpperCase() == e.symbol).toList();
  }
}
