import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

//Customer request contain,  destination and pickuplocation that will be converted to lat and long

class DriverForwardGeocoding {
  Future<LatLng?> getCoordinatesFromAddress(String pickAddress) async {
    // Error handling and access token
    if (pickAddress.isEmpty) {
      debugPrint("Please provide a valid address.");
      return null;
    }
    String proximity = '71.5249%2C34.0151'; // Adjust if needed
    String accessToken = 'pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ';
    String url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$pickAddress.json?limit=1&country=pk&proximity=$proximity&access_token=$accessToken';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final features = data['features'] as List;
        // Check for successful results
        if (features.isEmpty) {
          debugPrint("No results found for '$pickAddress'");
          return null;
        }
        // Extract coordinates from the first feature (assuming one result)
        final center = features.first['center'] as List<dynamic>; // Type safety
        final latitude = center.first as double; // Type casting to double
        final longitude = center.last as double; // Type casting to double
        debugPrint("this is destination latitude $latitude");
        debugPrint("this is  destination longitude $longitude");
        return LatLng(latitude, longitude);
      } else {
        debugPrint("Error fetching coordinates: Status code ${response.statusCode}");
        return null;
      }
    }catch (error){
      debugPrint("Error: $error");
      return null;
    }
  }
}
