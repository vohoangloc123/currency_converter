import 'package:currencyconverter/utils/currency_converter.dart';
import 'package:flutter/material.dart';
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
  bool _isLoading = false;

  final List<String> currencies = ['USD', 'VND', 'EUR', 'GBP'];

  void _handleConvert() async {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    try {
      String sanitizedInput =
          _amountController.text.replaceAll(RegExp(r'[,.]'), '');
      amount = double.parse(sanitizedInput);

      if (_fromCurrency == 'VND' || _toCurrency == 'VND') {
        if (amount != amount.floorToDouble()) {
          showErrorSnackbar(context, 'VND must be a whole number.');
          return;
        }
      }

      if (amount <= 0) {
        showErrorSnackbar(context, 'Amount must be greater than 0.');
        return;
      }

      if (_fromCurrency == _toCurrency) {
        showErrorSnackbar(context, 'From and To currencies must be different.');
        return;
      }
    } catch (_) {
      showErrorSnackbar(
          context, 'Invalid amount. Please enter a valid number.');
      return;
    }

    setState(() {
      _isLoading = true;
      _convertedAmount = null;
    });

    final result = await convertCurrency(
      amount: amount,
      fromCurrency: _fromCurrency!,
      toCurrency: _toCurrency!,
      context: context,
    );

    setState(() {
      _isLoading = false;
      _convertedAmount = result;
    });
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
              onPressed: _handleConvert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            if (_isLoading)
              SpinKitPouringHourGlass(
                color: Theme.of(context).colorScheme.primary,
                size: 100.0,
              )
            else if (_convertedAmount != null)
              Text(
                'Converted Amount: ${_convertedAmount!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
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
