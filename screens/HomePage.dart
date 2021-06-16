import 'package:flutter/material.dart';
import '../widgets/potholes_list.dart';
import '../screens/input_screen.dart';
import 'package:provider/provider.dart';
import '../providers/admin.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final bool isAdmin = Provider.of<Admin>(context).getAdmin;
    // print("Is Admin from homepage.dart : $isAdmin");
    // print("App was rebuilt");
    return Scaffold(
      appBar: AppBar(
        title: Text('Pothole App'),
      ),
      body: PotHolesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(InputPage.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
