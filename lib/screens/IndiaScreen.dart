import 'dart:convert';
import 'dart:ui';
import 'package:covid19tracker/models/IndiaData.dart';
import 'package:covid19tracker/screens/WorldScreen.dart';
import 'package:covid19tracker/widgets/india_total_data_row.dart';
import 'package:covid19tracker/widgets/indian_states_data_row.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:covid19tracker/constants/api_urls.dart';
import 'package:covid19tracker/models/IndianStates.dart';

class IndiaScreen extends StatefulWidget {
  static const routeName = '/indiaScreen';

  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

class _IndiaScreenState extends State<IndiaScreen> {
  List<IndianStates> stateList = [];
  Map map;
  bool loader = false;
  Future<IndiaData> indiaData;
  List<Map> todayDataList = [];
  Future<List<IndianStates>> indianStatesData;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loader,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FutureBuilder<IndiaData>(
                future: indiaData,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    int active = snapshot.data.active;
                    int total = snapshot.data.total;
                    int recovered = snapshot.data.recovered;
                    int deaths = snapshot.data.deaths;
                    int todayTests = snapshot.data.todayTests;
                    int totalTests = snapshot.data.tests;
                    return Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 12,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: PieChart(
                                        PieChartData(
                                            borderData:
                                                FlBorderData(show: false),
                                            sections: [
                                              PieChartSectionData(
                                                  showTitle: true,
                                                  titleStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                  value:
                                                      WorldScreen.getPercentage(
                                                          active, total),
                                                  title:
                                                      '${WorldScreen.getPercentage(active, total).toStringAsFixed(1)}%',
                                                  color: Colors.blueAccent,
                                                  radius: 30),
                                              PieChartSectionData(
                                                  showTitle: true,
                                                  value:
                                                      WorldScreen.getPercentage(
                                                          recovered, total),
                                                  title:
                                                      '${WorldScreen.getPercentage(recovered, total).toStringAsFixed(1)}%',
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
                                                  value:
                                                      WorldScreen.getPercentage(
                                                          deaths, total),
                                                  title:
                                                      '${WorldScreen.getPercentage(deaths, total).toStringAsFixed(1)}%',
                                                  color: Colors.red,
                                                  radius: 30),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IndiaTotalDataRow(
                                        cases: total,
                                        label: 'Total',
                                        showIcon: 0,
                                      ),
                                      IndiaTotalDataRow(
                                        cases: active,
                                        label: 'Active',
                                        iconColor: Colors.blue,
                                      ),
                                      IndiaTotalDataRow(
                                        cases: recovered,
                                        label: 'Recovered',
                                        iconColor: Colors.green,
                                      ),
                                      IndiaTotalDataRow(
                                        cases: deaths,
                                        label: 'Deaths',
                                        iconColor: Colors.red[800],
                                      ),
                                      IndiaTotalDataRow(
                                        cases:
                                            totalTests == null ? 0 : totalTests,
                                        label: 'Total Tests',
                                        showIcon: 0,
                                      ),
                                      IndiaTotalDataRow(
                                        cases:
                                            todayTests == null ? 0 : todayTests,
                                        label: 'Todays\'s Test',
                                        showIcon: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else
                    return Expanded(
                      flex: 3,
                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text('Loading...'),
                        ),
                      ),
                    );
                }),
            Expanded(
              flex: 9,
              child: FutureBuilder<List<IndianStates>>(
                  future: indianStatesData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          final stateList = snapshot.data;
                          return Card(
                            elevation: 5,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      stateList[index].location,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 2),
                                    IndianStateDataRow(
                                      label: 'Total Cases',
                                      cases: stateList[index].totalCases,
                                      todayCases: 0,
                                    ),
                                    IndianStateDataRow(
                                      label: 'Active Cases',
                                      cases: stateList[index].activeCases,
                                      todayCases: 0,
                                    ),
                                    IndianStateDataRow(
                                      label: 'Recovered',
                                      cases: stateList[index].recovered,
                                      todayCases: 0,
                                    ),
                                    IndianStateDataRow(
                                      label: 'Deaths',
                                      todayCases: 0,
                                      cases: stateList[index].deaths,
                                    ),
                                    IndianStateDataRow(
                                        label: 'Tests',
                                        cases: stateList[index].todayTested,
                                        todayCases: 0),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    indiaData = dataOfIndia();
    indianStatesData = getData();
  }

  Future<List<IndianStates>> getData() async {
    setState(() {
      loader = true;
    });

    try {
      final response1 = await get(APIUrls.urlOfIndianStates);
      if (response1.statusCode == 200) {
        final response2 = await get(APIUrls.timeSeriesTillToday);
        final responseOfTotalStates =
            jsonDecode(response1.body)['data']['regional'] as List;
        final responseOfTodayCases = jsonDecode(response2.body) as Map;
        final dateTime = DateTime.now();
        final now = DateFormat('yyyy-MM-dd').format(dateTime);

        responseOfTodayCases.forEach((key, value) {
          final item = responseOfTodayCases[key]['dates'] as Map;
          todayDataList.add({
            'todayCases':
                item.containsKey(now) ? item[now]['total']['confirmed'] : 0,
            'todayDeaths':
                item.containsKey(now) ? item[now]['total']['deceased'] : 0,
            'todayRecover':
                item.containsKey(now) ? item[now]['total']['recovered'] : 0,
            'todayActive': 199,
            'tested': item.containsKey(now) ? item[now]['total']['tested'] : 0,
          });
        });

        for (int i = 0; i < responseOfTotalStates.length; i++) {
          final stateData = responseOfTotalStates[i];
          stateList.add(IndianStates(
            location: stateData['loc'],
            recovered: stateData['discharged'],
            deaths: stateData['deaths'],
            totalCases: stateData['totalConfirmed'],
            activeCases: stateData['totalConfirmed'] -
                stateData['discharged'] -
                stateData['deaths'],
            todayRecover: todayDataList[i]['todayRecover'],
            todayCases: todayDataList[i]['todayCases'],
            todayDeaths: todayDataList[i]['todayDeaths'],
            todayActive: todayDataList[i]['todayActive'],
            todayTested: todayDataList[i]['tested'],
          ));
        }
      }
      setState(() {
        loader = false;
      });
    } catch (e) {
      print(e);
    }
    return stateList;
  }

  Future<IndiaData> dataOfIndia() async {
    Response response = await get(APIUrls.urlOfIndianStates);
    if (response.statusCode >= 200) {
      final responseBody = jsonDecode(response.body);
      int total = responseBody['data']['summary']['total'];
      int recovered = responseBody['data']['summary']['discharged'];
      int deaths = responseBody['data']['summary']['deaths'];
      int activeCases = total - recovered - deaths;
      final tests = await getTest();
      final obj = IndiaData(
        total: total,
        recovered: recovered,
        deaths: deaths,
        active: activeCases,
        tests: int.parse(tests['todayTests']),
        todayTests: int.parse(tests['totalTests']),
      );
      return obj;
    }
  }

  Future<Map> getTest() async {
    final response = await get(APIUrls.testUrl);
    if (response.statusCode >= 200) {
      final responseBody = json.decode(response.body)['tested'];
      final testsMap = {
        'totalTests': responseBody.last['totalsamplestested'],
        'todayTests': responseBody.last['samplereportedtoday']
      };
      return testsMap;
    }
  }
}
