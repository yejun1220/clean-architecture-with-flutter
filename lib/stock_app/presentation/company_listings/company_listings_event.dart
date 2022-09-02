import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listings_event.freezed.dart';

@freezed
abstract class CompanyListingsEvent with _$CompanyListingsEvent {
  const factory CompanyListingsEvent.refreshCompanyListings() = RefreshCompanyListings;
  const factory CompanyListingsEvent.onSearchQueryChange(String query) = OnSearchQueryChange;
}