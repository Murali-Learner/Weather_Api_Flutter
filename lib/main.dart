// @dart=2.9

import 'package:flutter/material.dart';
import 'package:weather_api/apiResponse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final apiResponse = ApiResponse();
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    WeatherData _weatherData;

    TextEditingController _searchController = TextEditingController();

    Future _search() async {
      final response = await apiResponse.apiResponse(_searchController.text);
      setState(() => _weatherData = response);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Weahter Api'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 60,
            left: 30,
            right: 30,
          ),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'City',
                    labelStyle: new TextStyle(color: const Color(0xFF424242)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  controller: _searchController,
                ),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.only(top: 100, left: 50),
                child: GestureDetector(
                  onTap: () {
                    _search();
                    // print("object");
                    // print(_weatherData.cityName != null
                    //     ? _weatherData.cityName
                    //     : 'data null');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: _height * 0.07,
                    width: _width * 0.6,
                    child: Text(
                      "Weather",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                child: Stack(
                  children: [Text('data')],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
