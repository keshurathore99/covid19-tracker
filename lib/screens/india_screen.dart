import 'dart:convert';
import 'dart:ui';
import 'package:covid19tracker/mixins/pie_chart_section_data.dart';
import 'package:covid19tracker/models/india_data.dart';
import 'package:covid19tracker/screens/world_screen.dart';
import 'package:covid19tracker/widgets/india_total_data_row.dart';
import 'package:covid19tracker/widgets/indian_states_data_row.dart';
import 'package:covid19tracker/widgets/loading_bar_for_total_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:covid19tracker/constants/api_urls.dart';
import 'package:covid19tracker/models/indian_states.dart';

class IndiaScreen extends StatelessWidget with PieChartOfCases {
  static const routeName = '/indiaScreen';
  final List<IndianStates> stateList = [];
  final List<Map> todayDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FutureBuilder<IndiaData>(
              future: dataOfIndia(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingBarForTotalData(
                    expandedFlex: 3,
                  );
                } else {
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: PieChart(
                                      PieChartData(
                                          borderData: FlBorderData(show: false),
                                          sections: [
                                            pieChartSectionData(
                                                total: total,
                                                cases: active,
                                                color: Colors.blueAccent),
                                            pieChartSectionData(
                                                total: total,
                                                cases: recovered,
                                                color: Colors.green),
                                            pieChartSectionData(
                                                total: total,
                                                cases: deaths,
                                                color: Colors.red),
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
                }
              }),
          Expanded(
            flex: 9,
            child: FutureBuilder<List<IndianStates>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else {
//                    snapshot.data.sort((a,b)=> b.totalCases.compareTo(a.totalCases));
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<List<IndianStates>> getData() async {
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
    return IndiaData(
        total: 0, recovered: 0, deaths: 0, active: 0, tests: 0, todayTests: 0);
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
    return {'totalTests': 0, 'todayTests': 0};
  }

  PieChartSectionData pieChartSectionData(
      {@required int total, @required int cases, @required Color color}) {
    return PieChartSectionData(
        showTitle: true,
        titleStyle: TextStyle(color: Colors.white, fontSize: 10),
        value: WorldScreen.getPercentage(cases, total),
        title: '${WorldScreen.getPercentage(cases, total).toStringAsFixed(1)}%',
        color: color,
        radius: 30);
  }
}
