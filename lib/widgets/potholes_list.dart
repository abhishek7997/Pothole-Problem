import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/pothole_item.dart';
import '../providers/potholes.dart';
import '../providers/pothole.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class PotHolesList extends StatelessWidget {
  final _stream = _firestore.collection('potholes').snapshots();

  Future<File> _createFileFromString(String encodedStr) async {
    Uint8List bytes = base64Decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    return file;
  }

  void buildList(potholesData, snapshot) async {
    final potholes = snapshot.data.docs;
    List<PotHole> lops = [];
    for (var pt in potholes) {
      final id = pt['id'];
      final address = pt['address'];
      final latitude = pt['latitude'];
      final longitude = pt['longitude'];
      var image;
      var P;
      await _createFileFromString(pt['image']).then((value) {
        image = value;
        P = PotHole(
          id: id,
          currentPosition:
              Position.fromMap({'latitude': latitude, 'longitude': longitude}),
          address: address,
          image: image,
        );
        lops.add(P);
      });
    }
    potholesData.clear();
    potholesData.addAllPotholes(lops);
    print(potholesData.items);
  }

  @override
  Widget build(BuildContext context) {
    var potholesData = Provider.of<PotHoles>(context);
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          buildList(potholesData, snapshot);
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: potholesData.items.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: potholesData.items[i],
              child: PotHoleItem(),
            ),
          );
        }
      },
    );
  }
}

// class PotHolesList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final potholesData = Provider.of<PotHoles>(context);
//     final potholes = potholesData.items;
//     return ListView.builder(
//       padding: const EdgeInsets.all(10.0),
//       itemCount: potholesData.items.length,
//       itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//         value: potholes[i],
//         child: PotHoleItem(),
//       ),
//     );
//   }
// }
