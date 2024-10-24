import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  String time = ''; //the time in that location
  String flag; //url flag asset
  String url; //location url for api endpoint
  bool isDayTime = false; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri link = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(link);
      Map data = jsonDecode(response.body);

      // //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create datetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}

WorldTime instance =
    WorldTime(location: 'Kuching', flag: 'Malaysia.png', url: 'Asia/Kuching');
