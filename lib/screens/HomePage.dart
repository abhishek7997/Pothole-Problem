import 'package:flutter/material.dart';
import 'package:pothole_problem/screens/welcome_screen.dart';
import '../widgets/potholes_list.dart';
import '../screens/input_screen.dart';
import 'package:provider/provider.dart';
import '../providers/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pothole App'),
        ),
        drawer: HomeDrawer(),
        body: PotHolesList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(InputPage.routeName);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            child: DrawerHeader(
              decoration: BoxDecoration(
                border: Border(),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.email.toString() ?? '',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            minLeadingWidth: 20.0,
            title: const Text('Sign out'),
            onTap: () async {
              await FirebaseAuth.instance
                  .signOut()
                  .then(
                    (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                        WelcomeScreen.routeName, (route) => false),
                  )
                  .catchError((onError) => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          WelcomeScreen.routeName, (route) => false));
            },
          ),
        ],
      ),
    );
  }
}
