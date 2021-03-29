import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pothole_problem/screens/welcome_screen.dart';
import './screens/pothole_detail_screen.dart';
import './screens/registration_screen.dart';
import './screens/login_screen.dart';
import 'package:provider/provider.dart';
import './screens/input_screen.dart';
import './screens/HomePage.dart';
import 'providers/potholes.dart';
import 'providers/pothole.dart';
import 'providers/admin.dart';
import 'screens/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PotHoles()),
        ChangeNotifierProvider.value(value: PotHole()),
        ChangeNotifierProvider.value(value: Admin()),
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
          initialRoute: WelcomeScreen.routeName,
          routes: {
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            MyHomePage.routeName: (context) => MyHomePage(),
            PotHoleDetailScreen.routeName: (ctx) => PotHoleDetailScreen(),
            InputPage.routeName: (ctx) => InputPage(),
            RegistrationScreen.routeName: (context) => RegistrationScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
          },
        ),
      ),
    );
  }
}
