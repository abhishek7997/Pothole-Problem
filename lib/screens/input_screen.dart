import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/potholes.dart';
import '../providers/pothole.dart';
import 'package:provider/provider.dart';

class InputPage extends StatelessWidget {
  static const routeName = '/input-screen';
  TextEditingController textController = TextEditingController();
  String roughGPSLocation = "";

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<PotHole>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Column(
        children: [
          CustomInputs(),
          GiveLocation(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Adding Pothole - Dummy Data");
          Provider.of<PotHoles>(context, listen: false).addPothole(
            PotHole(
              id: 'p5',
              currentPosition: settingsProvider.CurrentPosition,
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class GiveLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<PotHole>(context);
    _getCurrentLocation(BuildContext context) {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        settingsProvider.setPosition = position;
      }).catchError((e) {
        print(e);
      });
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            size: 46.0,
            color: Colors.blue,
          ),
          SizedBox(height: 10.0),
          Text(
            'Get User Location',
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Consumer<PotHole>(
            builder: (context, data, child) {
              return Text(settingsProvider.CurrentPosition != null
                  ? 'LAT: ${settingsProvider.Latitude} LON: ${settingsProvider.Longitude}'
                  : "Null Location");
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[800],
            ),
            onPressed: () => _getCurrentLocation(context),
            child: Text(
              "Get Current Location",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Consumer<PotHole>(
            builder: (context, data, child) {
              return Text(settingsProvider.CurrentPosition != null
                  ? 'Address : ${settingsProvider.Address}'
                  : "Null Address");
            },
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
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
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontFamily: 'OpenSans',
            ),
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
