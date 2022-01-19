import 'package:http/http.dart';
import 'dart:convert';

class worker {
  String location = "";
  String temperature = "";
  String humidity = "";
  String air_speed = "";
  String description = "";
  String main_des = "";
  String icon_val = "";
  String latitude = "";
  String longitude = "";
  String city_name ="";
  //method to

  worker({
    this.location = "",
    lat_value = "",
    lon_value = "",
  }) {
    location = this.location;
    latitude = lat_value;
    longitude = lon_value;
  }

  Future<void> getData() async {
    print("Loading API");

    try {
      //getting the data
      Response response;
      if (location != "") {
        print(
            "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=c730bf30e8accebe02bd2b6fba228e96");
        response = await get(Uri.parse(
            "http://api.openweathermap.org/data/2.5/weather?q=$location&appid=c730bf30e8accebe02bd2b6fba228e96"));
      } else {
        print("object");
        response = await get(Uri.parse(
            "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=c730bf30e8accebe02bd2b6fba228e96"));
      }
      Map data = jsonDecode(response.body);
      print("API Loaded");
      //getting temp, humidity
      Map temp_data = data['main'];
      double getTemp = temp_data['temp'] - 273.15; // in degree celsius
      String getHumid = temp_data['humidity'].toString(); // in percentage

      //getting weather and description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];

      //getting air speed
      Map wind = data['wind'];
      double getAir_speed = wind["speed"] * 3.6; // in km/h

      //getting icons
      String icon_value = weather_main_data['icon'];
      

      //getting city name
      city_name = data["name"];

      //Assigning values
      temperature = getTemp.toString();
      humidity = getHumid;
      air_speed = getAir_speed.toString();
      description = getDesc;
      main_des = getMain_des;
      icon_val = icon_value;
    } catch (error) {
      print(error);
      temperature = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "Can't find data";
      main_des = "NA";
      icon_val = "09d";
    }
  }
}


//worker instance = worker(location: "Mumbai");