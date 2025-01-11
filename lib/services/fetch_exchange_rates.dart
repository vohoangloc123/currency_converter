import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, double>> fetchExchangeRates() async {
  const url =
      'https://v6.exchangerate-api.com/v6/0e7f7658027a6f71dd477a9d/latest/USD';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    data['conversion_rates'].forEach((currency, rate) {
      print('$currency: $rate');
    });
    return {
      "USD": (data['conversion_rates']['USD'] as num).toDouble(),
      "VND": (data['conversion_rates']['VND'] as num).toDouble(),
      "EUR": (data['conversion_rates']['EUR'] as num).toDouble(),
      "GBP": (data['conversion_rates']['GBP'] as num).toDouble(),
    };
  } else {
    throw Exception('Failed to load exchange rates');
  }
}
