import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';

import '../models/calendar_day_data_model.dart';
import '../repository/calendar_repository.dart';

class DashboardViewModel extends ChangeNotifier {
  DateTime solarDate = DateTime.now();
  LunarDate? lunarDate;
  CalendarDayData? todayData;

  DashboardViewModel() {
    _initToday(); // Gọi khi init
  }

  Future<void> _initToday() async {
    solarDate = DateTime.now();
    lunarDate = LunarDate.fromSolar(solarDate);
    todayData = await CalendarRepository().getDayData(solarDate);
    notifyListeners(); // UI rebuild ngay
  }

  void setDate(DateTime solar, LunarDate lunar) {
    solarDate = solar;
    lunarDate = lunar;
    notifyListeners();
  }

  Future<void> loadDate(DateTime date) async {
    todayData = await CalendarRepository().getDayData(date);
    notifyListeners();
  }

  String get solarString =>
      "${solarDate.day}/${solarDate.month}/${solarDate.year}";
  String get lunarString => lunarDate != null
      ? "${lunarDate!.day}/${lunarDate!.month}/${lunarDate!.year}"
      : "";
}
