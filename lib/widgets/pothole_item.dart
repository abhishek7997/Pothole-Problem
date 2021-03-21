import 'package:flutter/material.dart';
import 'package:pothole_problem/screens/pothole_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/pothole.dart';

class PotHoleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pothole = Provider.of<PotHole>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
        child: ListTile(
          trailing: Icon(pothole.isFixed ? Icons.check : Icons.clear),
          title: Row(
            children: [
              Text(
                pothole.id,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "LAT: ${pothole.Latitude}, LONG: ${pothole.Longitude}",
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "${pothole.Address}",
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(PotHoleDetailScreen.routeName, arguments: pothole);
          },
        ),
      ),
    );
  }
}
