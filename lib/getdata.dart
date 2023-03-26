
import 'dart:convert';
import 'package:http/http.dart' as http;

class Getcdata{
  String selectedcurrency = "USD";
  double price = 0;
  var apikey = "9DF69AE3-C047-4F4D-A5A6-3DA53DAC85A7";
   List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

  Future getcoindata(String currency) async{
    Map<String, String> cryptoprices = {};
    for(String crypto in cryptoList){
      String url = "https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apikey";
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;

      price =  jsonDecode(data)['rate'];
      cryptoprices[crypto] = price.toStringAsFixed(0);

    }
    return cryptoprices;
  }
}