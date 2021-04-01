import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:async';

class PageTwo extends StatefulWidget {
  String result;
  PageTwo({Key key, @required this.result}) : super(key: key);
  String minTip;

  @override
  _PageTwoState createState() => _PageTwoState(result);
}

MyHomePage name = new MyHomePage();

class _PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    super.initState();
    _calculate();
  }

  Future<String> _calculate() async {
    tipAmount = sliderValue / 100 * double.parse(result);
    total = ((tipAmount) + double.parse(result));
    return "Success";
  }

  String result;
  _PageTwoState(this.result);

  static double sliderValue = 5;
  double minValue = 5;
  double maxValue = 15;
  int divisionValue = 10;

  double tipAmount = sliderValue;
  double total = 85.99;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tippy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.orange[500],
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
              child: Text(
                'Total:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 30),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 50,
              right: 50,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 40,
                right: 40,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 1)),
              child: Text(
                total.toStringAsFixed(2),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Tip Percentage',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Min',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 1)),
                    child: Text(
                      sliderValue.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.orange),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Max',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 60, left: 60),
            child: Slider(
              min: minValue,
              max: maxValue,
              divisions: divisionValue,
              value: sliderValue,
              activeColor: Colors.orangeAccent,
              inactiveColor: Colors.orange,
              onChanged: (newValue) {
                setState(() {
                  sliderValue = newValue;
                  tipAmount = sliderValue / 100 * double.parse(result);
                  total = ((tipAmount) + double.parse(result));
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Tip Amount',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 50,
              right: 50,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: 40,
                right: 40,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 1)),
              child: Text(
                tipAmount.toStringAsFixed(2),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(-0.85, 1.0),
        child: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          backgroundColor: Colors.orange[500],
          foregroundColor: Colors.white,
          tooltip: 'Go Back!',
        ),
      ),
    );
  }
}
