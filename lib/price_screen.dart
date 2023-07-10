import 'package:bitcoin_ticker/card.dart';
import 'package:bitcoin_ticker/coin_api.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'USD';
  double btcRate = 0;
  double ethRate = 0;
  double ltcRate = 0;

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      DropdownMenuItem<String> newItem = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        btcRate = await CoinAPI('BTC', value).getRate();
        ethRate = await CoinAPI('ETH', value).getRate();
        ltcRate = await CoinAPI('LTC', value).getRate();
        setState(() {
          selectCurrency = value!;
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Widget> pickerItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      Text newitem = Text(currenciesList[i]);
      pickerItems.add(newitem);
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          print(index);
        },
        children: pickerItems);
  }

  void getData(String currency) async {
    try {
      double btcData = await CoinAPI('BTC', currency).getRate();
      double ethData = await CoinAPI('ETH', currency).getRate();
      double ltcData = await CoinAPI('LTC', currency).getRate();
      setState(() {
        btcRate = btcData;
        ethRate = ethData;
        ltcRate = ltcData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData('USD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: PriceCard('BTC', btcRate, selectCurrency).priceCard(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: PriceCard('LTC', ltcRate, selectCurrency).priceCard(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: PriceCard('ETH', ethRate, selectCurrency).priceCard(),
              ),
            ],
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
          )
        ],
      ),
    );
  }
}
