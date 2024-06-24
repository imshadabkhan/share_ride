import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class Navigation_Services{
  Future getNavigation({ start_Coords, end_Coords})async{
    try{
    String public_token='pk.eyJ1IjoiaW1zaGFkYWJraGFuIiwiYSI6ImNsdHZiam54NzFwaGMyb29hc21hZndidWwifQ.zAVfo5CWXYISVxuRSGVSPQ';
    String base_url='https://api.mapbox.com/directions/v5/driving/';
    String Api_url='$base_url$start_Coords;$end_Coords?alternatives=false&geometries=geojson&overview=simplified&steps=false&notifications=none&access_token=$public_token';
    var response = await http.get(Uri.parse(Api_url));
    if(response.statusCode==200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse.toString();    }
    }catch(e){debugPrint(" Error Fetching Navigation Api  Error =" + e.toString());
    }







  }


}

