import 'dart:convert';

import 'file:///C:/Users/lenovo/Desktop/AndroidStudioProjects/time_tracking_app/covid19_tracker/lib/constants/api_urls.dart';
import 'file:///C:/Users/lenovo/Desktop/AndroidStudioProjects/time_tracking_app/covid19_tracker/lib/models/WorldCountry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WorldScreen extends StatefulWidget {
  static const routeName = '/worldScreen';

  static double getPercentage(var cases, var totalCases) {
    double percentage = (cases / totalCases) * 100;
    return percentage;
  }

  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  int totalCases = 0,
      totalDeaths = 0,
      activeCases = 0,
      recovered = 0,
      todayCases = 0,
      todayDeaths = 0,
      critical = 0,
      totalTests = 0;
  bool loader = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loader,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 12,
                              child: PieChart(
                                PieChartData(
                                    borderData: FlBorderData(show: false),
                                    sections: [
                                      PieChartSectionData(
                                          showTitle: true,
                                          titleStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          value: WorldScreen.getPercentage(
                                              activeCases, totalCases),
                                          title:
                                              '${WorldScreen.getPercentage(activeCases, totalCases).toStringAsFixed(1)}%',
                                          color: Colors.blueAccent,
                                          radius: 30),
                                      PieChartSectionData(
                                          showTitle: true,
                                          value: WorldScreen.getPercentage(
                                              recovered, totalCases),
                                          title:
                                              '${WorldScreen.getPercentage(recovered, totalCases).toStringAsFixed(1)}%',
                                          titleStyle: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                          color: Colors.green,
                                          radius: 30),
                                      PieChartSectionData(
                                          showTitle: true,
                                          titleStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          value: WorldScreen.getPercentage(
                                              totalDeaths, totalCases),
                                          title:
                                              '${WorldScreen.getPercentage(totalDeaths, totalCases).toStringAsFixed(1)}%',
                                          color: Colors.red,
                                          radius: 30),
                                    ]),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Total : $totalCases',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '+${todayCases.toString()}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blueAccent),
                                      ),
                                      Opacity(
                                          opacity: 0,
                                          child: Icon(
                                            Icons.stop,
                                            size: 18,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Active : $activeCases',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.stop,
                                        color: Colors.blue,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Recovered : $recovered',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.stop,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Deaths : $totalDeaths',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '+${todayDeaths.toString()}',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red[900]),
                                      ),
                                      Icon(
                                        Icons.stop,
                                        color: Colors.red[800],
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Tests : $totalTests',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Critical : ${critical.toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Card(
                  elevation: 5,
                  child: FutureBuilder(
                    future: getListData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          itemCount:
                              snapshot.data == null ? 0 : snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text((index + 1).toString()),
                                        Text(
                                          snapshot.data[index].country,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Opacity(
                                            opacity: 0,
                                            child: Text(index.toString())),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Total Cases',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '${snapshot.data[index].totalCases.toString()}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '+${snapshot.data[index].todayCases.toString()}',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.blueAccent),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Active ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].activeCases
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Recovered',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].recovered
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Total Deaths',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data[index].totalDeaths
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '+${snapshot.data[index].todayDeaths.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: Colors.red[800]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Tests Till Now',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data[index].totalTests
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getWorldData() async {
    Response response = await get(APIUrls.worldUrlOfToday);
    if (response.statusCode == 200) {
      var responseBody = await jsonDecode(response.body);
      setState(() {
        totalCases = responseBody['cases'];
        totalDeaths = responseBody['deaths'];
        activeCases = responseBody['active'];
        recovered = responseBody['recovered'];
        todayCases = responseBody['todayCases'];
        todayDeaths = responseBody['todayDeaths'];
        critical = responseBody['critical'];
        totalTests = responseBody['tests'];
        loader = false;
      });
    }
  }

  Future<List<WorldCountry>> getListData() async {
    List<WorldCountry> list = [];
    try {
      Response response = await get(APIUrls.totalDataOfToday);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        for (var data in jsonData) {
          WorldCountry worldCountry = WorldCountry(
              country: data['country'],
              totalCases: data['cases'],
              todayCases: data['todayCases'],
              recovered: data['recovered'],
              totalDeaths: data['deaths'],
              todayDeaths: data['todayDeaths'],
              activeCases: data['active'],
              criticalCases: data['critical'],
              totalTests: data['tests']);
          list.add(worldCountry);
        }
        return list;
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
      print(e);
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    getWorldData();
    getListData();
  }
}
