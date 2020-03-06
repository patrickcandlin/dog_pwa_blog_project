import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All About Dogs!',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'All About Dogs!'),
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
  bool _clicked = false;
  var _dog = "";

  void _handelClick() {
    _getDog();
    setState(() {
      _clicked = !_clicked;
    });
  }

  Future<String> _getDog() async {
    var dogUrl = 'https://dog.ceo/api/breeds/image/random';
    var response = await http.get(dogUrl);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var parsedResponse = jsonResponse as Map<String, dynamic>;
      setState(() {
        _dog = parsedResponse['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (_clicked)
          ? Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(
                            image: NetworkImage(_dog),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(child: Text('Change Dogs?'), onPressed: _getDog,)
                ],
              ),
          )
          : Center(
              child: RaisedButton(
                child: Text(
                  'Click to see dogs!',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: _handelClick,
              ),
            ),
    );
  }
}
