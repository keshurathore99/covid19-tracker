import 'package:flutter/foundation.dart';

class IndianStates {
  final String location;
  int activeCases,
      recovered,
      deaths,
      totalCases,
      todayRecover,
      todayDeaths,
      todayCases,
      todayActive,
      todayTested;

  IndianStates(
      {@required this.todayDeaths,
      @required this.todayCases,
      @required this.todayActive,
      @required this.location,
      @required this.activeCases,
      @required this.recovered,
      @required this.deaths,
      @required this.todayRecover,
      @required this.totalCases,
      @required this.todayTested});
}
