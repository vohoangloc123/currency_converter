import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _fromCurrency = 'USD';
  String? _toCurrency = 'VND';
  double? _convertedAmount;
  String? _errorMessage;
  bool _isLoading = false;

  final List<String> currencies = ['USD', 'VND', 'EUR', 'GBP'];

  Future<void> convertCurrency() async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset error message
    });
    final apiKey = dotenv.env['API_KEY'];
    final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$_fromCurrency?symbols=$_toCurrency');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['conversion_rates'] != null &&
            data['conversion_rates'][_toCurrency] != null) {
          double conversionRate = data['conversion_rates'][_toCurrency];
          double convertedAmount = amount * conversionRate;

          setState(() {
            _convertedAmount = convertedAmount;
          });
        } else {
          setState(() {
            _errorMessage = 'Conversion rates or $_toCurrency not found';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch exchange rates';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _fromCurrency,
              items: currencies
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _fromCurrency = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'From Currency',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _toCurrency,
              items: currencies
                  .map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _toCurrency = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'To Currency',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            if (_isLoading)
              SpinKitPouringHourGlass(
                color: Theme.of(context).colorScheme.primary,
                size: 100.0,
              )
            else if (_errorMessage != null)
              Text(
                'Error: $_errorMessage',
                style: const TextStyle(color: Colors.red),
              )
            else if (_convertedAmount != null)
              Column(
                children: [
                  Text(
                    'Converted Amount: ${_convertedAmount!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Converted From: $_fromCurrency to $_toCurrency',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )
            else
              const Text(
                'Chưa chuyển đổi',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
