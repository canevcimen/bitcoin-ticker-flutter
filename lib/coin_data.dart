import 'dart:convert';
import 'package:http/http.dart' as http;
import 'price_screen.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'TRY',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

const apikey = '0EB99A9D-22F6-44C0-8A7D-6CC38A6BAAC2#';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        double price = decodedData['rate'];

        cryptoPrices[crypto]=price.toStringAsFixed(0);

      } else {
        print(response.statusCode);

        throw 'Problem with the request';
      }
    }
    return cryptoPrices;
  }
}
