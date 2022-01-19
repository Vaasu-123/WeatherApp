//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Loading extends StatefulWidget {
  Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temp = "";
  String hum = "";
  String air_spd = "";
  String desc = "";
  String main_desc = "";
  String city = "Pilani";

  void getLocation() async {
    try {
      await Permission.location.request();
      var status = await Permission.location.status;
      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        worker instance = worker(lat_value: position.latitude.toString(), lon_value: position.longitude.toString());
        await instance.getData();
        print(instance);
        print("Accessedd in getLocation");
        temp = instance.temperature;
        hum = instance.humidity;
        air_spd = instance.air_speed;
        desc = instance.description;
        main_desc = instance.main_des;
        city = instance.city_name;
        await Future.delayed(
          Duration(seconds: 2),
        );

        Navigator.pushReplacementNamed(
          context,
          "/home",
          arguments: {
            "temp_value": temp,
            "hum_value": hum,
            "air_speed_value": air_spd,
            "des_value": desc,
            "main_desc_value": main_desc,
            "icon_value": instance.icon_val,
            "city_name": city,
          },
        );
      } else {
        print("city not found");
        city = "Pilani";
        startApp();
      }
    } catch (e) {
      print("There was an error while getting location");
      print(e);
      city = "Pilani";
      startApp();
    }
  }

  void startApp() async {
    //Fetching data particular to a location

    // await Permission.location.request();
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);

    worker instance = worker(location: city);
    await instance.getData();
    print(instance);

    temp = instance.temperature;
    hum = instance.humidity;
    air_spd = instance.air_speed;
    desc = instance.description;
    main_desc = instance.main_des;

    await Future.delayed(
      Duration(seconds: 2),
    );

    Navigator.pushReplacementNamed(
      context,
      "/home",
      arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_spd,
        "des_value": desc,
        "main_desc_value": main_desc,
        "icon_value": instance.icon_val,
        "city_name": city,
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;
    if (search == null) {
      print("Activating getLocation");
      getLocation();
    } else {
      print("Searching via name");
      city = search['searchText'];
      startApp();
    }
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: 200,
            ),
            Text(
              "Weather App",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.amber[400],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Made by Vaasu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.amber[400],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
