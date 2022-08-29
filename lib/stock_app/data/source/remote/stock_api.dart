import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = 'R53L4WV6XQ6KQUNO';

  final http.Client client;

  StockApi(this.client);

  Future<http.Response> getListings(String apiKey) async {
    return await client.get(Uri.parse('${baseUrl}query?function=LISTING_STATUS&apiKey=$apiKey'));
  }
}
