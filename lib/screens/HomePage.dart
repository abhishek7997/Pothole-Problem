import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/pothole.dart';
import '../widgets/potholes_list.dart';
import '../screens/input_screen.dart';
import '../providers/pothole.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print("App was rebuilt");
    return Scaffold(
      appBar: AppBar(
        title: Text('Pothole App'),
      ),
      body: PotHolesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).pushNamed(InputPage.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
