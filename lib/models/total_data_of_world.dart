import 'package:flutter/foundation.dart';

class TotalDataOfWorld {
  int totalCases,
      totalDeaths,
      activeCases,
      recovered,
      todayCases,
      todayDeaths,
      critical,
      totalTests;

  TotalDataOfWorld(
      {@required this.totalCases,
      @required this.totalDeaths,
      @required this.activeCases,
      @required this.recovered,
      @required this.todayCases,
      @required this.todayDeaths,
      @required this.critical,
      @required this.totalTests});
}
