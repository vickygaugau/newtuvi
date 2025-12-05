import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sieutuvi/values/app_assets.dart'; // để format giờ

class Utils {
  static String getCurrentTime24h() {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  static String getImage12congiap(String text) {
    switch (text) {
      // Ti
      case "day_giap img_ty":
        return AppAssets.cgTi;
      // Suu
      case "day_giap img_suu":
        return AppAssets.cgSuu;
      // Dan
      case "day_giap img_dan":
        return AppAssets.cgDan;
      // Meo
      case "day_giap img_mao":
        return AppAssets.cgMeo;
      // Thin
      case "day_giap img_thin":
        return AppAssets.cgThin;
      // Ty
      case "day_giap img_ty2":
        return AppAssets.cgTy;
      // Ngo
      case "day_giap img_ngo":
        return AppAssets.cgNgo;
      // Mui
      case "day_giap img_mui":
        return AppAssets.cgMui;
      // Than
      case "day_giap img_than":
        return AppAssets.cgThan;
      // Dau
      case "day_giap img_dau":
        return AppAssets.cgDau;
      // Tuat
      case "day_giap img_tuat":
        return AppAssets.cgTuat;
      // Hoi
      case "day_giap img_hoi":
        return AppAssets.cgHoi;
      default:
        return AppAssets.cgThin;
    }
  }

  static Widget createBackgroundWidget({required Widget child}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.bg, fit: BoxFit.cover)),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.1)),
          ),
          Column(children: [child]),
        ],
      ),
    );
  }
}
