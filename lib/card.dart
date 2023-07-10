import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceCard {
  double rate;
  String selectCurrency;
  String crypto;

  PriceCard(this.crypto, this.rate, this.selectCurrency);

  Card priceCard() {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          '1 $crypto = ${rate.toStringAsFixed(0)} $selectCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
