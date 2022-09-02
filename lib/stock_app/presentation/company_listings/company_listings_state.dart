import 'package:clean_architecture/stock_app/domain/model/company_listing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_listings_state.freezed.dart';

part 'company_listings_state.g.dart';

@freezed
class CompanyListingsState with _$CompanyListingsState {
  const factory CompanyListingsState({
    @Default([]) List<CompanyListing> companies,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default('false') String searchQuery,
  }) = _CompanyListingState;

  factory CompanyListingsState.fromJson(Map<String, Object?> json) => _$CompanyListingsStateFromJson(json);
}
