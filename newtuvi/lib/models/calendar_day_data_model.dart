import 'dart:convert';

class CalendarDayData {
  final String lichDuongTitle;
  final String lichDuongNgay;
  final String lichDuongThu;
  final String lichDuongImage;

  final String lichAmTitle;
  final String lichAmNgay;

  final List<String> lichAmChiTiet;

  final List<String> gioHoangDao;
  final List<String> gioHacDao;

  final List<String> gioMatTroi;
  final List<String> gioMatTrang;

  final List<String> huongXuatHanh;
  final List<String> hopXung;
  final List<String> tuoiBiXungKhac;
  final List<String> saoTotXau;
  final List<String> viecTotXau;

  CalendarDayData({
    this.lichDuongTitle = "",
    this.lichDuongNgay = "",
    this.lichDuongThu = "",
    this.lichDuongImage = "",
    this.lichAmTitle = "",
    this.lichAmNgay = "",
    this.lichAmChiTiet = const [],
    this.gioHoangDao = const [],
    this.gioHacDao = const [],
    this.gioMatTroi = const [],
    this.gioMatTrang = const [],
    this.huongXuatHanh = const [],
    this.hopXung = const [],
    this.tuoiBiXungKhac = const [],
    this.saoTotXau = const [],
    this.viecTotXau = const [],
  });

  factory CalendarDayData.fromJson(Map<String, dynamic> json) {
    List<String> safeList(dynamic value) {
      if (value == null) return [];
      if (value is List) {
        return value.map((e) => e?.toString() ?? "").toList();
      }
      return [];
    }

    return CalendarDayData(
      lichDuongTitle: json["LichDuongTitle"] ?? "",
      lichDuongNgay: json["LichDuongNgay"] ?? "",
      lichDuongThu: json["LichDuongThu"] ?? "",
      lichDuongImage: json["LichDuongImage"] ?? "",

      lichAmTitle: json["LichAmTitle"] ?? "",
      lichAmNgay: json["LichAmNgay"] ?? "",

      lichAmChiTiet: safeList(json["LichAmChiTiet"]),
      gioHoangDao: safeList(json["GioHoangDao"]),
      gioHacDao: safeList(json["GioHacDao"]),
      gioMatTroi: safeList(json["GioMatTroi"]),
      gioMatTrang: safeList(json["GioMatTrang"]),

      huongXuatHanh: safeList(json["HuongXuatHanh"]),
      hopXung: safeList(json["HopXung"]),
      tuoiBiXungKhac: safeList(json["TuoiBiXungKhac"]),
      saoTotXau: safeList(json["SaoTotXau"]),
      viecTotXau: safeList(json["ViecTotXau"]),
    );
  }
}
