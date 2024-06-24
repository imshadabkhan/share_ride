
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../global_variable/global_variable.dart';

class DestinationReverseGeocodingService {
  Future<String> getDestinationAddressFromCoordinations(double latitude, double longitude) async {
    try {
      // Construct the API endpoint URL
      String url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=sk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHdkaGZ3OTFvdG8ybG5qOThhaWZsZHQifQ.U92O1TdnwoKSCnXGAE_f-w';

      // Make the GET request to the API
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = jsonDecode(response.body);

        // Extract the address from the response (example)
        var features = jsonResponse['features'];
        if (features.isNotEmpty) {
          var firstFeature = features[0];
          gdestinationaddress = firstFeature['place_name'];
          debugPrint(
              "destinationaddress => $gdestinationaddress");

          return gdestinationaddress;



        }
      }

      // Return an empty string if address not found or other error occurs
      return 'address not found';
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error: $e');
      // Return an empty string or throw an error as needed
      return 'NO result found';
    }
  }




}
