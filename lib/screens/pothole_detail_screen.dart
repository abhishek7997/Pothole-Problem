import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pothole.dart';
import '../providers/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

User loggedInUser;

class PotHoleDetailScreen extends StatefulWidget {
  static const routeName = '/pothole-detail';

  @override
  _PotHoleDetailScreenState createState() => _PotHoleDetailScreenState();
}

class _PotHoleDetailScreenState extends State<PotHoleDetailScreen> {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final PotHole pothole =
        ModalRoute.of(context).settings.arguments as PotHole;
    final isAdminProvider = Provider.of<Admin>(context);

    final _data = _firestore
        .collection('potholes')
        .orderBy("id", descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(pothole.Id),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text("Unique ID : ${pothole.Id}"),
              ),
              Table(
                // border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 10.0),
                        child: Text(
                          "GPS Location",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latitude    :  ${pothole.Latitude}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Longitude :  ${pothole.Longitude}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Estimated Address",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 250.0,
                          child: Text(
                            " ${pothole.Address}",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IsFixedIndicator(isFixed: pothole.isFixed),
                      isAdminProvider.getAdmin != null
                          ? (isAdminProvider.getAdmin
                              ? Switch(
                                  onChanged: (val) {
                                    // isAdminProvider.setAdmin(val);
                                    setState(() {
                                      pothole.setFixed = val;
                                      print(pothole.getFixed);
                                      _firestore
                                          .collection('potholes')
                                          .doc(pothole.Id)
                                          .update(
                                              {'isfixed': pothole.getFixed});
                                    });
                                  },
                                  value: pothole.getFixed,
                                  activeColor: Colors.blue,
                                  activeTrackColor: Colors.yellow,
                                  inactiveThumbColor: Colors.redAccent,
                                  inactiveTrackColor: Colors.orange,
                                )
                              : (pothole.isFixed
                                  ? Text("Fixed")
                                  : Text(
                                      "Not Fixed, contact your administrator")))
                          : Text("isAdmin is set to null"),
                    ],
                  )),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Image.file(pothole.Image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IsFixedIndicator extends StatelessWidget {
  bool isFixed;
  IsFixedIndicator({this.isFixed});

  @override
  Widget build(BuildContext context) {
    return isFixed
        ? CircleAvatar(
            backgroundColor: Colors.green,
            radius: 50.0,
            child: Icon(
              Icons.check,
              size: 80.0,
            ),
          )
        : CircleAvatar(
            backgroundColor: Colors.red,
            radius: 50.0,
            child: Icon(
              Icons.clear,
              size: 80.0,
            ),
          );
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text(
// "GPS Location : ${pothole.Latitude} , ${pothole.Longitude}",
// style: TextStyle(fontSize: 20.0),
// ),
// Text(
// "Estimated Address : ${pothole.Address}",
// style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
// ),
// ClipRRect(
// borderRadius: BorderRadius.circular(15.0),
// child: FractionallySizedBox(
// widthFactor: 0.8, child: Image.file(pothole.Image)),
// ),
// ],
// ),
