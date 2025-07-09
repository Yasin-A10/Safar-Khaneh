import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicker extends StatefulWidget {
  final String? initialLatitude; // مختصات اولیه (اختیاری)
  final String? initialLongitude;
  final Function(double latitude, double longitude)
  onLocationSelected; // کال‌بک برای برگرداندن مختصات

  const MapPicker({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
    required this.onLocationSelected,
  });

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    // تنظیم لوکیشن اولیه
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _selectedLocation = LatLng(
        double.parse(widget.initialLatitude!),
        double.parse(widget.initialLongitude!),
      );
    } else {
      // اگه لوکیشن اولیه وجود نداشت، یه لوکیشن پیش‌فرض (مثلاً مرکز تهران) تنظیم می‌کنیم
      _selectedLocation = const LatLng(35.6892, 51.3890);
    }
    _updateMarker();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _updateMarker() {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('selected_location'),
          position: _selectedLocation,
          infoWindow: const InfoWindow(title: 'مکان انتخاب‌شده'),
        ),
      };
    });
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _updateMarker();
      // ارسال مختصات به والد
      widget.onLocationSelected(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'انتخاب مکان',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 300,
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14.0,
              ),
              mapType: MapType.normal,
              markers: _markers,
              onTap: _onMapTapped, // تپ روی نقشه
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'مختصات: ${_selectedLocation.latitude}, ${_selectedLocation.longitude}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
