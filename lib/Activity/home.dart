import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
//import '../Worker/worker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map info = ModalRoute.of(context)?.settings.arguments as Map;

    String temp = info['temp_value'].toString();
    if (temp != "NA") {
      try {
        temp = temp.substring(0, 4);
      } catch (e) {
        temp = temp.substring(0, 2);
      }
    }

    String icon_value = info['icon_value'];
    String cityName = info['city_name'];
    String hum = info['hum_value'];
    String airspd = info['air_speed_value'].toString();
    if (airspd != "NA") {
      try {
        airspd = airspd.substring(0, 4);
      } catch (e) {
        try {
          airspd = airspd.substring(0, 3);
        } catch (e) {
          airspd = airspd.substring(0,2);
        }
      }
    }

    String desc = info['des_value'];
    String mainDecValue = info['main_desc_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
          //shadowColor: Colors.transparent,
        ),
      ),
      //backgroundColor: Colors.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade300,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              // search box container
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if ((searchController.text).replaceAll(" ", "") == "") {
                        print("Blank Search");
                      } else {
                        Navigator.pushReplacementNamed(context, "/loading",
                            arguments: {"searchText": searchController.text});
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search any city name",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Image.network(
                            "http://openweathermap.org/img/wn/$icon_value@2x.png",
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mainDecValue,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "In $cityName",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Icon(
                          WeatherIcons.thermometer,
                          size: 25,
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height / 3) / 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              temp,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 10,
                              ),
                            ),
                            Text(
                              "°C",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(25),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.day_windy),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          airspd,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("km/hr"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.fromLTRB(5, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: EdgeInsets.all(25),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.humidity),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          hum,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Percent"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: const Text(
                "Weather App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
