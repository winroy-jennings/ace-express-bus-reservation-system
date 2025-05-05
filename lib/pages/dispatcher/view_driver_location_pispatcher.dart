import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ViewDriverLocationPispatcher extends StatelessWidget {
  const ViewDriverLocationPispatcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View Driver Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: FlutterMap(
          options: const MapOptions(
            initialCenter:
                // LatLng(51.509364, -0.128928), // Center the map over London
                LatLng(18.01653057691507,
                    -76.74360940083913), // Center the map over London
            initialZoom: 17.0,
          ),
          children: [
            TileLayer(
              // Display map tiles from any source
              urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
            ),
          ],
        ),
      ),
    );
  }
}
