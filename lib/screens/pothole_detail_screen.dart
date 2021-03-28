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
                child: pothole.isFixed
                    ? CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 60.0,
                        child: Icon(
                          Icons.check,
                          size: 90.0,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 60.0,
                        child: Icon(
                          Icons.clear,
                          size: 90.0,
                        ),
                      ),
              ),
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
