import 'package:clean_architecture/stock_app/data/source/remote/dto/intraday_info_dto.dart';
import 'package:clean_architecture/stock_app/domain/model/intraday_info.dart';
import 'package:intl/intl.dart';

extension ToIntradayInfo on IntradayInfoDto {
  IntradayInfo toIntradayInfo() {
    final formatter = DateFormat('yyyy-mm-dd hh:mm:ss');
    return IntradayInfo(date: formatter.parse(timestamp), close: close);
  }
}