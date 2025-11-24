import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';

import '../models/calendar_day_data_model.dart';
import '../repository/calendar_repository.dart';

class DashboardViewModel extends ChangeNotifier {
  DateTime solarDate = DateTime.now();
  LunarDate? lunarDate;
  CalendarDayData? todayData;
  List<String> listLoiHayYDep = [];

  DashboardViewModel() {
    _initToday(); // Gọi khi init
  }

  Future<void> _initToday() async {
    solarDate = DateTime.now();
    lunarDate = LunarDate.fromSolar(solarDate);
    todayData = await CalendarRepository().getDayData(solarDate);
    listLoiHayYDep = await CalendarRepository().getLoiHayYDep();
    notifyListeners(); // UI rebuild ngay
  }

  String getThangNamString() {
    return "Tháng ${solarDate.month} năm ${solarDate.year}";
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

  String getLichAmChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.lichAmChiTiet ?? []).length; i++) {
      full += (todayData?.lichAmChiTiet ?? [])[i];
      full += "\n";
    }
    return full;
  }

  String getGioHoangDaoChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.gioHoangDao ?? []).length; i++) {
      full += (todayData?.gioHoangDao ?? [])[i];
      if (i < (todayData?.gioHoangDao ?? []).length - 1) {
        full += "   -   ";
      }
    }
    return full;
  }

  String getGioHacDaoChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.gioHacDao ?? []).length; i++) {
      full += (todayData?.gioHacDao ?? [])[i];
      if (i < (todayData?.gioHacDao ?? []).length - 1) {
        full += "   -   ";
      }
    }
    return full;
  }

  String getGioMatTrangChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.gioMatTrang ?? []).length; i++) {
      full += (todayData?.gioMatTrang ?? [])[i];
      if (i < (todayData?.gioMatTrang ?? []).length - 1) {
        full += "   -   ";
      }
    }
    return full;
  }

  String getGioMatTroiChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.gioMatTroi ?? []).length; i++) {
      full += (todayData?.gioMatTroi ?? [])[i];
      if (i < (todayData?.gioMatTroi ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String getViecNenLamChiTiet() {
    var full = "";
    for (var i = 0; i < (todayData?.viecTotXau ?? []).length; i++) {
      full += (todayData?.viecTotXau ?? [])[i];
      if (i < (todayData?.viecTotXau ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String getHuongXuatHanh() {
    var full = "";
    for (var i = 0; i < (todayData?.huongXuatHanh ?? []).length; i++) {
      full += (todayData?.huongXuatHanh ?? [])[i];
      if (i < (todayData?.huongXuatHanh ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String getHopXung() {
    var full = "";
    for (var i = 0; i < (todayData?.hopXung ?? []).length; i++) {
      full += (todayData?.hopXung ?? [])[i];
      if (i < (todayData?.hopXung ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String getTuoiXungKhac() {
    var full = "";
    for (var i = 0; i < (todayData?.tuoiBiXungKhac ?? []).length; i++) {
      full += (todayData?.tuoiBiXungKhac ?? [])[i];
      if (i < (todayData?.tuoiBiXungKhac ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String getSaoTotXau() {
    var full = "";
    for (var i = 0; i < (todayData?.saoTotXau ?? []).length; i++) {
      full += (todayData?.saoTotXau ?? [])[i];
      if (i < (todayData?.saoTotXau ?? []).length - 1) {
        full += "\n";
      }
    }
    return full;
  }

  String get solarString =>
      "${solarDate.day}/${solarDate.month}/${solarDate.year}";
  String get lunarString => lunarDate != null
      ? "${lunarDate!.day}/${lunarDate!.month}/${lunarDate!.year}"
      : "";
}
