import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  final locacionGPS = Location();
  final isLoading = false.obs;

  final latitud = (-12.083979).obs;
  final longitud = (-76.971385).obs;
  final focused = false.obs;

  final Key mapKey = UniqueKey();

  Future<void> checkPermisoDeUbicacion() async {
    try {
      isLoading.value = true;
      await locacionGPS.hasPermission();
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> obtenerUbicacion() async {
    try {
      final currentLocationData = await locacionGPS.getLocation();

      latitud.value = currentLocationData.latitude!;
      longitud.value = currentLocationData.longitude!;
    } catch (e) {
      // print("error al obtener la ubiación $e");
    }
  }

  Future<void> actualizarMapController(MapController mapController) async {
    try {
      isLoading.value = true;

      await obtenerUbicacion();
      mapController.move(LatLng(latitud.value, longitud.value), 15.0);
    } catch (e) {
      // handle errors
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkPermisoDeUbicacion();
  }
}
