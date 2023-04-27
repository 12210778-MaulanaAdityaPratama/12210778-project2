import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class PetaProvider with ChangeNotifier{
  LocationAccuracy _accuracy = LocationAccuracy.low;
  LatLng latLng = LatLng(0, 0);
  LatLng latlng_lama = LatLng(0, 0);

  MapController mapController = MapController();
  bool mapReady = false;
  bool mulaibaca = false;

  void mulai_bacalokasi(){
    if (mulaibaca == false){
      mulaibaca = true;
      _bacalokasi();
    }

  }
  void stop_bacalokasi(){
    mulaibaca = false;

  }
  Future <bool> cekIzin()async{
    var izin = await Geolocator.checkPermission();
    if(izin != LocationPermission.always &&
    izin != LocationPermission.whileInUse){
      izin = await Geolocator.requestPermission();
    }
    if (izin != LocationPermission.always &&
    izin != LocationPermission.whileInUse){
      return false;
    }
    return true;
  }
  Future bacalokasi()async{
    final izin = await cekIzin();
    if(izin == false) return;

    try {
      final lokasi = await Geolocator.getCurrentPosition(desiredAccuracy: _accuracy);
      latLng = LatLng(lokasi.latitude, lokasi.longitude);
      naikkan_akurasi();
      
    } catch (e) {
      
    }

  }
  void turunkan_akurasi(){
    if (_accuracy == LocationAccuracy.bestForNavigation) {
      _accuracy = LocationAccuracy.best;
      
    }else if (_accuracy == LocationAccuracy.best){
      _accuracy = LocationAccuracy.medium;
    }else if (_accuracy == LocationAccuracy.best){
      _accuracy = LocationAccuracy.low;
    }

  }
  void naikkan_akurasi(){
    if (_accuracy == LocationAccuracy.low) {
      _accuracy = LocationAccuracy.medium;
      
    }else if (_accuracy == LocationAccuracy.medium){
      _accuracy = LocationAccuracy.best;
    }else if (_accuracy == LocationAccuracy.best){
      _accuracy = LocationAccuracy.bestForNavigation;
    }

  }
}