import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location = ''; // location name for the UI
  String time = ''; // the time in that location
  String flag = ''; // url to an asset flag icon
  String url = ''; //location URL for api end point
  bool isDaytime = true; // is day or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response response = await get(
          Uri.parse('https://www.worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);

      //print(data);

      // get properties from data

      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print(datetime);
      //print (offset);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);

      // adding the offset to get the correct time
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error : $e');
      time = 'Could not get time data';
    }
  }
}
