import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/stock_info.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  var _isLoading = false;
  List<StockInfo> _stockExtractedDataList = [];
  List<StockInfo> _stockInfoList = [];

  ScrollController controller;
  Future<void> fetchInfo() async {
    final urlRecord = Uri.parse(
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=SBIN.BSE&apikey=G8WCON85U6CQWRFI');

    try {
      final response = await http.get(urlRecord);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (extractedData == null) {
        return;
      }

      extractedData['Time Series (Daily)'].forEach((stockDate, stockData) {
//        print(stockData['1. open']);

        StockInfo stockInfo = StockInfo(
          date: stockDate,
          open: stockData['1. open'],
          high: stockData['2. high'],
          low: stockData['3. low'],
          close: stockData['4. close'],
          adjustedClose: stockData['5. adjusted close'],
          volume: stockData['6. volume'],
          dividendAmount: stockData['7. dividend amount'],
          splitCoefficient: stockData['8. split coefficient'],
        );

        _stockExtractedDataList.add(stockInfo);
      });

      _stockInfoList.addAll(
          new List.generate(20, (index) => _stockExtractedDataList[index]));
    } catch (error) {
      print(error);
    }
  }

  Widget _buildTextRow(String head, String tail) {
    return Row(
      children: <Widget>[
        Text(head),
        Spacer(),
        Text(tail),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  var count = 0;
  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      setState(() {
        count++;
        _stockInfoList.addAll(new List.generate(
            20, (index) => _stockExtractedDataList[index + (20 * count)]));
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    setState(() {
      _isLoading = true;
    });
    fetchInfo().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height * 0.59,
      margin: EdgeInsets.only(top: deviceSize.height * 0.1),
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: deviceSize.height * 0.58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(6.0),
                child: Scrollbar(
                  child: GridView.builder(
                    controller: controller,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: deviceSize.height * 0.3,
                      childAspectRatio: 10 / 9,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _stockInfoList.length,
                    itemBuilder: (ctx, index) => Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _stockInfoList[index].date,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            _buildTextRow(
                                '1. Open', _stockInfoList[index].open),
                            _buildTextRow(
                                '2. High', _stockInfoList[index].high),
                            _buildTextRow('3. Low', _stockInfoList[index].low),
                            _buildTextRow(
                                '4. Close', _stockInfoList[index].close),
                            _buildTextRow('5. Adjusted Close',
                                _stockInfoList[index].adjustedClose),
                            _buildTextRow(
                                '6. Volume', _stockInfoList[index].volume),
                            _buildTextRow('7. Dividend Amount',
                                _stockInfoList[index].dividendAmount),
                            _buildTextRow('8. Split Coefficient',
                                _stockInfoList[index].splitCoefficient),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
