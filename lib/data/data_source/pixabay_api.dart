import 'dart:convert';

import 'package:http/http.dart' as http;

class PixabayApi {
  final http.Client client;

  PixabayApi(this.client);

  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '28262654-10d1d88c92ffee267c6caee5e';

  Future<Iterable> fetch(String query) async {
    final response = await client.get(Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo'));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits;
  }
}
