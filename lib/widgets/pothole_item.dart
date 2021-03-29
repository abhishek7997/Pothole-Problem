import 'package:flutter/material.dart';
import 'package:pothole_problem/screens/pothole_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/pothole.dart';

class PotHoleItem extends StatelessWidget {
  PotHoleItem();

  @override
  Widget build(BuildContext context) {
    final pothole = Provider.of<PotHole>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFd8e2dc),
            borderRadius: BorderRadius.circular(15.0)),
        child: ListTile(
          trailing: Icon(pothole.isFixed ? Icons.check : Icons.clear),
          title: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                // height: double.infinity,
                alignment: Alignment.center,
                child: Image.file(
                  pothole.Image,
                  fit: BoxFit.contain,
                  width: 65,
                  height: 65,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "LAT: ${pothole.Latitude}, LONG: ${pothole.Longitude}",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        "${pothole.Address}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
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
