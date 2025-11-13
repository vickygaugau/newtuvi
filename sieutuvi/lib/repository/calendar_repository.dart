import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/calendar_day_data_model.dart';

class CalendarRepository {
  /// Cache để load 1 lần
  final Map<int, Map<String, CalendarDayData>> _cache = {};

  /// Load dữ liệu của 1 năm
  Future<Map<String, CalendarDayData>> loadYear(int year) async {
    if (_cache.containsKey(year)) return _cache[year]!;

    final fileText = await rootBundle.loadString(
      "assets/data/lichvannien/$year.txt",
    );

    final records = fileText.split("----------");
    final Map<String, CalendarDayData> dataMap = {};

    for (var record in records) {
      if (record.trim().isEmpty) continue;

      final parts = record.split("+++");
      if (parts.length != 2) continue;

      final key = parts[0].trim();
      final jsonStr = parts[1].trim();

      final json = jsonDecode(jsonStr);
      dataMap[key] = CalendarDayData.fromJson(json);
    }

    _cache[year] = dataMap;
    return dataMap;
  }

  /// Lấy data theo ngày
  Future<CalendarDayData?> getDayData(DateTime date) async {
    final year = date.year;

    final map = await loadYear(year);
    final key = "${date.day}_${date.month}_$year";

    return map[key];
  }

  /// Lấy data theo ngày
  Future<List<String>> getLoiHayYDep() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/data/loihayydep/loihayydep.txt',
      );

      // Tách theo "-----"
      final quotes = raw
          .split('-----')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      return quotes;
    } catch (e) {
      print('Lỗi khi đọc file loihayydep.txt: $e');
      return [];
    }
  }
}
