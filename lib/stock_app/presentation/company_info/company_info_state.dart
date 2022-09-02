import 'package:clean_architecture/stock_app/domain/model/company_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_state.freezed.dart';

part 'company_info_state.g.dart';

@freezed
class CompanyInfoState with _$CompanyInfoState {
  const factory CompanyInfoState({
    CompanyInfo? companyInfo,
    @Default(false) bool isLoading,
  }) = _CompanyInfoState;

  factory CompanyInfoState.fromJson(Map<String, Object?> json) => _$CompanyInfoStateFromJson(json);
}