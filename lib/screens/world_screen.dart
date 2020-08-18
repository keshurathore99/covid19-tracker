import 'dart:convert';
import 'package:covid19tracker/constants/api_urls.dart';
import 'package:covid19tracker/models/world_country.dart';
import 'package:covid19tracker/mixins/pie_chart_section_data.dart';
import 'package:covid19tracker/models/total_data_of_world.dart';
import 'package:covid19tracker/widgets/loading_bar_for_total_data.dart';
import 'package:covid19tracker/widgets/world_countries_data_row.dart';
import 'package:covid19tracker/widgets/world_total_data_row.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WorldScreen extends StatelessWidget with PieChartOfCases {
  static const routeName = '/worldScreen';

  static double getPercentage(var cases, var totalCases) {
    double percentage = (cases / totalCases) * 100;
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FutureBuilder<TotalDataOfWorld>(
              future: getWorldData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return LoadingBarForTotalData(
                    expandedFlex: 1,
                  );
                else {
                  int totalCases = snapshot.data.totalCases,
                      totalDeaths = snapshot.data.totalDeaths,
                      activeCases = snapshot.data.activeCases,
                      recovered = snapshot.data.recovered,
                      todayCases = snapshot.data.todayCases,
                      todayDeaths = snapshot.data.todayDeaths,
                      critical = snapshot.data.critical,
                      totalTests = snapshot.data.totalTests;
                  return Expanded(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 12,
                                    child: PieChart(
                                      PieChartData(
                                          borderData: FlBorderData(show: false),
                                          sections: [
                                            pieChartSectionData(
                                                total: totalCases,
                                                cases: activeCases,
                                                color: Colors.blueAccent),
                                            pieChartSectionData(
                                                total: totalCases,
                                                cases: recovered,
                                                color: Colors.green),
                                            pieChartSectionData(
                                                total: totalCases,
                                                cases: totalDeaths,
                                                color: Colors.red),
                                          ]),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          WorldTotalDataRow(
                                            label: 'Total',
                                            totalCases: totalCases,
                                            isThereTodayCases: true,
                                            todayCases: todayCases,
                                            showIcon: 0,
                                          ),
                                          WorldTotalDataRow(
                                            totalCases: activeCases,
                                            label: 'Active',
                                            showIcon: 1,
                                            iconColor: Colors.blueAccent,
                                          ),
                                          WorldTotalDataRow(
                                            totalCases: recovered,
                                            label: 'Recovered',
                                            showIcon: 1,
                                            iconColor: Colors.green,
                                          ),
                                          WorldTotalDataRow(
                                            totalCases: totalDeaths,
                                            label: 'Deaths',
                                            showIcon: 1,
                                            isThereTodayCases: true,
                                            todayCases: todayDeaths,
                                            iconColor: Colors.red,
                                            todayCasesTextColor: Colors.red,
                                          ),
                                          WorldTotalDataRow(
                                            totalCases: totalTests,
                                            label: 'Tests',
                                            showIcon: 0,
                                          ),
                                          WorldTotalDataRow(
                                            totalCases: critical,
                                            label: 'Critical',
                                            showIcon: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
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
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
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
                                  WorldCountriesDataRow(
                                    label: 'Total Case',
                                    cases: snapshot.data[index].totalCases,
                                    isThereTodayCases: true,
                                    todayCases: snapshot.data[index].todayCases,
                                  ),
                                  WorldCountriesDataRow(
                                    label: 'Active',
                                    cases: snapshot.data[index].activeCases,
                                    isThereTodayCases: false,
                                    todayCases: snapshot.data[index].todayCases,
                                  ),
                                  WorldCountriesDataRow(
                                    label: 'Recovered',
                                    cases: snapshot.data[index].recovered,
                                  ),
                                  WorldCountriesDataRow(
                                    label: 'Total Deaths',
                                    cases: snapshot.data[index].totalDeaths,
                                    isThereTodayCases: true,
                                    todayCases:
                                        snapshot.data[index].todayDeaths,
                                  ),
                                  WorldCountriesDataRow(
                                    label: 'Tests Till Now',
                                    cases: snapshot.data[index].totalTests,
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
    );
  }

  Future<TotalDataOfWorld> getWorldData() async {
    Response response = await get(APIUrls.worldUrlOfToday);
    if (response.statusCode == 200) {
      var responseBody = await jsonDecode(response.body);
      return TotalDataOfWorld(
          totalCases: responseBody['cases'],
          totalDeaths: responseBody['deaths'],
          activeCases: responseBody['active'],
          recovered: responseBody['recovered'],
          todayCases: responseBody['todayCases'],
          todayDeaths: responseBody['todayDeaths'],
          critical: responseBody['critical'],
          totalTests: responseBody['tests']);
    }
    return TotalDataOfWorld(
        totalCases: 0,
        totalDeaths: 0,
        activeCases: 0,
        recovered: 0,
        todayCases: 0,
        todayDeaths: 0,
        critical: 0,
        totalTests: 0);
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
      print(e);
    }
    return list;
  }
}
