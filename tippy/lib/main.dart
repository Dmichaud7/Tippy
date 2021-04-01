import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'ui/pagetwo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tippy',
      color: Colors.orangeAccent,
      home: MyHomePage(title: 'Tippy'),
      theme: ThemeData(
        hintColor: Colors.orange,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    fromTextController.dispose();
    super.dispose();
  }

  static String letter2 = r"[a-zA-Z,-]+$";
  RegExp regLet = RegExp(letter2);

  final fromTextController = TextEditingController();
  List<String> currencies = [];
  String fromCurrency = "CAD";
  String toCurrency = "USD";
  String result = "1";
  String currencyCategory;

  String minTip = "5";
  String maxTip = "15";
  String _mySelection;

  List<Map> _myJson = [
    {"id": "1", "name": "Restaurant", "min": "5", "max": "15"},
    {"id": "2", "name": "Delivery", "min": "5", "max": "15"},
    {"id": "3", "name": "Bartender", "min": "5", "max": "15"},
     {"id": "4", "name": "Taxi", "min": "5", "max": "15"}
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  bool isDouble(num value) => value is double || value == value.roundToDouble();

  bool isNum(num x) => x is int || x.truncateToDouble() == x;

  Future<String> _loadCurrencies() async {
    String uri = "https://api.exchangeratesapi.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});

    return "Success";
  }

  Future<String> _doConversion() async {
    String uri =
        "http://api.openrates.io/latest?base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) *
              (responseBody["rates"][toCurrency]))
          .toString();
    });

    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.orange[500],
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Center(
            child: Container(
              padding:
                  EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
              child: Text(
                'Amount:',
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
              left: 50,
              right: 50,
            ),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.orange,
                cursorColor: Colors.orange,
              ),
              child: TextField(
                controller: fromTextController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  height: 2,
                  color: Colors.orange,
                ),
                decoration: InputDecoration(
                    labelText: "Enter your bill",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      height: 2,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Current:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 25),
                  ),
                ),
                Expanded(
                    child: Text(
                  'Convert to:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 25),
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 40, left: 40),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                    child: DropdownButton<String>(
                      value: fromCurrency,
                      style: TextStyle(color: Colors.orange),
                      items: currencies
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Row(
                                  children: <Widget>[
                                    Text(value),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (String value) {
                        if (fromCurrency == fromCurrency) {
                          _onFromChanged(value);
                        } else {
                          _onToChanged(value);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 60),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                    child: DropdownButton<String>(
                      value: toCurrency,
                      style: TextStyle(color: Colors.orange),
                      items: currencies
                          .map((String value) => DropdownMenuItem(
                                value: value,
                                child: Row(
                                  children: <Widget>[
                                    Text(value),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (String value) {
                        if (toCurrency == fromCurrency) {
                          _onFromChanged(value);
                        } else {
                          _onToChanged(value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Location:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 25),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, right: 70, left: 70),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
              child: DropdownButton<String>(
                value: _mySelection,
                style: TextStyle(color: Colors.orange),
                onChanged: (String newValue) {
                  setState(() {
                    _mySelection = newValue;
                  });
                },
                items: _myJson.map((Map map) {
                  print(minTip);
                  return DropdownMenuItem<String>(
                    child: new Text(map["name"]),
                    value: map["id"].toString(),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 80, right: 80),
            child: RaisedButton(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 24, right: 24),
              onPressed: () {
                print(fromTextController.text);

                if (fromTextController.text == "" ||
                    fromTextController.text == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("Invalid Input"),
                      content: Text("Please enter a number"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("ok"),
                        ),
                      ],
                    ),
                  );
                } else if (regLet.hasMatch(fromTextController.text)) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("Invalid Input"),
                      content: Text("Please enter a valid number"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else if (_mySelection == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("Invalid Input"),
                      content: Text("Please select a location"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                } else {
                  _doConversion();

                  Future.delayed(const Duration(milliseconds: 2000), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PageTwo(
                          result: result,
                        ),
                      ),
                    );
                  });
                }
                print(fromTextController.text);
              },
              textColor: Colors.white,
              color: Colors.orange,
              child: Text(
                'Calculate',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10, left: 80, right: 80),
            child: RaisedButton(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
              onPressed: () {
                fromTextController.clear();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text("Reset"),
                    content: Text("The amount was been reset"),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              textColor: Colors.white,
              color: Colors.orange,
              child: Text(
                'Reset',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
