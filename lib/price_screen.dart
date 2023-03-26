
import 'package:bitcoin/getdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:http/http.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';




class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Getcdata getcdata = Getcdata();
  var selectedcurrency = "USD";
  @override
  void initState()   {
    // TODO: implement initState
   getdata();
    super.initState();
  }

Map<String,String> coinvalues = {};
  String ETH = "";
  String LTC = "";
  String BTC = "";


void getdata() async {
  try{
    setState(() async {
      var data = await getcdata.getcoindata(selectedcurrency);
      coinvalues = data;
      print(coinvalues);
      LTC = coinvalues['LTC']!;
      ETH = coinvalues['ETH']!;
      BTC = coinvalues['BTC']!;
    });

  }catch(e){
    print(e);
  }
}

  DropdownButton getandroid(){
    List<DropdownMenuItem<String>> newitems = [];
    for (String currency in currencieList) {
      var newitem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      newitems.add(newitem);
    }
    return  DropdownButton<String>(
      value: getcdata.selectedcurrency,
      items: newitems,
      onChanged: (value){
        setState(() {
          getcdata.selectedcurrency = value!;
          getdata();
        });

      },
    );
  }

  CupertinoPicker getiospicker() {
    List<Widget> items = [];
    for (String currency in currencieList) {
      items.add(Text(currency));
    }
    return  CupertinoPicker(
      itemExtent: 32.0,
      children: items,
      onSelectedItemChanged: (selectedindex) {
      },
    );
  }
Widget getpicker(){
    if(Platform.isAndroid){
      return getandroid();
    }
      return getiospicker();

}

  @override
  Widget build(BuildContext context) {

    selectedcurrency = getcdata.selectedcurrency;
    getdata();
    var price = getcdata.price;
    return Scaffold(
      appBar: AppBar(

        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                    '1 BTC = $BTC $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ETH $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $LTC $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Spacer(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getpicker(),
          ),
        ],
      ),
    );
  }
}

