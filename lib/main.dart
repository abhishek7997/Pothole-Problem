import 'package:flutter/material.dart';
import './screens/pothole_detail_screen.dart';
import 'package:provider/provider.dart';
import './screens/input_screen.dart';
import 'providers/potholes.dart';
import 'providers/pothole.dart';
import 'screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PotHoles()),
        ChangeNotifierProvider.value(value: PotHole()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Pothole App',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.lightBlue,
          ),
          home: MyHomePage(),
          routes: {
            PotHoleDetailScreen.routeName: (ctx) => PotHoleDetailScreen(),
            InputPage.routeName: (ctx) => InputPage(),
          },
        ),
      ),
    );
  }
}
