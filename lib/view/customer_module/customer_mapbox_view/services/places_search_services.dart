// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class PlacesSearch_Services {
//   String baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
//   String accessToken =
//       "pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ";
//   String searchResultLimit = '5';
//   String searchType = 'place%2Cpoi';
//   String proximity = '71.560135%2C34.0151';
//   Future getSearchResultFromQueryUsingMapbox() async {
//     try {
//       String url =
//           "$baseUrl/museum.json?country=pk&limit=5&proximity=$proximity&types=$searchType&language=en&access_token=$accessToken";
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         debugPrint("this is the status code ${response.statusCode.toString()}");
//
//         final data = jsonDecode(response.body);
//         var features = data['features'];
//         if(features.isNotEmpty){
//           var firstFeature = features[1];
//           var placeName = firstFeature['place_name_en'].toString(); // English place name
//           debugPrint(placeName);
//            return placeName;    }
//
//       } else {
//         return "Result Not Found";
//       }
//
//
//     } catch(e){
//
//       debugPrint(e.toString());
//     }
//
//
//
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PlacesSearchServices {
  static const String baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
  static const String accessToken = "pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ";
  static const String searchType = 'poi%2Cplace%2Caddress';
  static const String proximity = '71.5249%2C34.0151';

  Future<List<String>> getSearchResultFromQueryUsingMapbox(String query) async {
    try {
      String url = "$baseUrl$query.json?country=pk&proximity=$proximity&limit=1&types=$searchType&language=en&access_token=$accessToken";
    // String url="https://api.mapbox.com/geocoding/v5/mapbox.places/mcd.json?country=pk&proximity=71.5249%2C34.0151&types=poi%2Cplace%2Caddress&language=en&access_token=pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ";
      final response = await http.get(Uri.parse(url));
      debugPrint("The Json response="+response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<String> placeNames=[];

        for (var feature in data['features']) {

          String placeName = feature['place_name_en'] as String;
          placeNames.add(placeName);
        }
        debugPrint(placeNames.toString());
        return placeNames;

      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
