import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/potholes.dart';
import '../providers/pothole.dart';

class PotHoleDetailScreen extends StatelessWidget {
  static const routeName = '/pothole-detail';
  @override
  Widget build(BuildContext context) {
    final PotHole pothole =
        ModalRoute.of(context).settings.arguments as PotHole;
    return Scaffold(
      appBar: AppBar(
        title: Text(pothole.Id),
      ),
      body: Center(
        child: Text("TODO"),
      ),
    );
  }
}
