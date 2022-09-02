import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co';
  static const apiKey = 'R53L4WV6XQ6KQUNO';

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getCompanyListings({String apiKey = apiKey}) async {
    return await _client.get(Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<http.Response> getCompanyInfo({
    required String symbol,
    String apiKey = apiKey,
  }) async {
    return await _client.get(Uri.parse('$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
  }
}
