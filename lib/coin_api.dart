import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '7AA9919B-E791-4EA8-85CB-B3749B9B82FC';

class CoinAPI {
  var currency;
  var crypto;

  CoinAPI(this.crypto, this.currency);

  Future<dynamic> getRate() async {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey';
    http.Response response = await http.get(Uri.parse(url));
    var price = jsonDecode(response.body)['rate'];
    return price;
  }
}
