import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  final String latitude;
  final String longitude;

  const MapWidget({super.key, required this.latitude, required this.longitude});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;
  late final Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: const MarkerId('residence_location'),
        position: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
        infoWindow: const InfoWindow(title: 'مکان اقامتگاه'),
      ),
    };
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'مکان',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.grey400,
              ),
            ),
            TextButton(
              onPressed: () async {
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}';
                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                  await launchUrl(Uri.parse(googleUrl));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('نمی‌توان نقشه را باز کرد')),
                  );
                }
              },
              child: const Text('باز کردن نقشه'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 230,
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)),
                zoom: 14.0,
              ),
              mapType: MapType.normal,
              markers: _markers,
            ),
          ),
        ),
      ],
    );
  }
}
