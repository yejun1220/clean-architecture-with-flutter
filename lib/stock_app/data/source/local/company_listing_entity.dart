import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CompanyListingEntity extends HiveObject{
  @HiveField(0)
  final String symbol;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String exchange;

  CompanyListingEntity({
    required this.symbol,
    required this.name,
    required this.exchange,
  });
}
