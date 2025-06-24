import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  StreamController<LatLng>? _locationController;
  StreamSubscription<Position>? _positionSubscription;
  bool _isTracking = false;

  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<LatLng?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return null;
    }
  }

  Stream<LatLng> startTracking() {
    if (_locationController?.isClosed ?? true) {
      _locationController = StreamController<LatLng>.broadcast();
    }

    if (!_isTracking) {
      _isTracking = true;
      _positionSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10, // metros
        ),
      ).listen((Position position) {
        if (_locationController?.isClosed ?? true) return;
        _locationController?.add(LatLng(position.latitude, position.longitude));
      });
    }

    return _locationController!.stream;
  }

  void stopTracking() {
    _isTracking = false;
    _positionSubscription?.cancel();
    _locationController?.close();
  }

  Future<double> calculateDistance(LatLng start, LatLng end) async {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  bool get isTracking => _isTracking;
} 