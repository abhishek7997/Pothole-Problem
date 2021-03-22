import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/potholes.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/pothole.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class InputPage extends StatelessWidget {
  static const routeName = '/input-screen';
  TextEditingController addressController = TextEditingController();
  String roughGPSLocation = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<PotHole>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // CustomInputs(),
              GiveLocation(settingsProvider),
              PickImage(settingsProvider),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (settingsProvider.currentPosition != null &&
              settingsProvider.image != null) {
            print("Adding Pothole - Dummy Data");
            Provider.of<PotHoles>(context, listen: false).addPothole(
              PotHole(
                id: 'p5',
                currentPosition: settingsProvider.CurrentPosition,
                address: settingsProvider.Address,
                image: settingsProvider.Image,
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Success!')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  (settingsProvider.currentPosition == null
                          ? 'Please Update your location '
                          : '') +
                      (settingsProvider.image == null
                          ? 'Please select an image '
                          : ''),
                ),
              ),
            );
            return;
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class PickImage extends StatelessWidget {
  final settingsProvider;
  PickImage(this.settingsProvider);

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      settingsProvider.setImage = _image;
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue[800],
          ),
          onPressed: () => getImage(),
          child: Column(
            children: [
              Icon(
                Icons.camera,
                size: 40.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "Pick Image",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Consumer<PotHole>(
          builder: (context, data, child) {
            return settingsProvider.image != null
                ? Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Image.file(settingsProvider.Image),
                    ),
                  )
                : Text("No Image is Selected");
          },
        ),
      ],
    );
  }
}

class GiveLocation extends StatelessWidget {
  final settingsProvider;
  GiveLocation(this.settingsProvider);

  _getCurrentLocation(BuildContext context) async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      settingsProvider.setPosition = position;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var settingsProvider = Provider.of<PotHole>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Icon(
          //   Icons.location_on,
          //   size: 46.0,
          //   color: Colors.blue,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                ),
                onPressed: () => _getCurrentLocation(context),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 40.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Get Current Location",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Consumer<PotHole>(
                    builder: (context, data, child) {
                      return Text(settingsProvider.CurrentPosition != null
                          ? 'LAT: ${settingsProvider.Latitude} LON: ${settingsProvider.Longitude}'
                          : "Location is set to NULL");
                    },
                  ),
                  SizedBox(height: 10.0),
                  Consumer<PotHole>(
                    builder: (context, data, child) {
                      return Text(settingsProvider.CurrentPosition != null
                          ? 'Address : ${settingsProvider.Address}'
                          : "Address is set to NULL");
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomInputs extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Rough Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
