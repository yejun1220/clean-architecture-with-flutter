import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_event.freezed.dart';

@freezed
abstract class CompanyInfoEvent with _$CompanyInfoEvent {
  const factory CompanyInfoEvent.loadCompanyInfo(String symbol) = LoadCompanyInfo;
}