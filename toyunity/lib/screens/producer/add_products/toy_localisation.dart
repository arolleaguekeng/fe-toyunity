import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapDialog extends StatefulWidget {
  const MapDialog({Key? key}) : super(key: key);

  @override
  _MapDialogState createState() => _MapDialogState();
}

class _MapDialogState extends State<MapDialog> {
  late GoogleMapController mapController;
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    //getCurrentLocation();
  }

  void getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _pickedLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _saveLocation() {
    if (_pickedLocation != null) {
      Navigator.of(context).pop(_pickedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        height: 300,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: _pickedLocation ?? LatLng(0, 0), zoom: 16),
          onTap: _selectLocation,
          markers: _pickedLocation != null
              ? {Marker(markerId: MarkerId('m1'), position: _pickedLocation!)}
              : {},
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Annuler')),
        TextButton(
            onPressed: _saveLocation,
            child: Text('Valider')),
      ],
    );
  }
}
