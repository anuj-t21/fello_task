import 'package:flutter/material.dart';

class StockInfo {
  String date;
  String open;
  String high;
  String low;
  String close;
  String adjustedClose;
  String volume;
  String dividendAmount;
  String splitCoefficient;

  StockInfo({
    @required this.date,
    @required this.open,
    @required this.high,
    @required this.low,
    @required this.close,
    @required this.adjustedClose,
    @required this.volume,
    @required this.dividendAmount,
    @required this.splitCoefficient,
  });
}
