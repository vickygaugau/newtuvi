import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_viewmodel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashboardViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          // Ngày Dương
          _buildNgayDuong(vm),
          const SizedBox(height: 18),
          // Ngày Âm
          _buildNgayAm(vm),
          // Calendar picker
          _buildXemThem(vm),
          // Chi tiết âm lịch
          _buildChiTietNgayAmLich(vm),
        ],
      ),
    );
  }

  Widget _buildNgayDuong(DashboardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wb_sunny, size: 32, color: Colors.orange),
        const SizedBox(width: 10),
        Text(
          vm.solarString,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNgayAm(DashboardViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.nights_stay, size: 28, color: Colors.purple),
        const SizedBox(width: 10),
        Text(
          vm.lunarString,
          style: const TextStyle(fontSize: 22, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildXemThem(DashboardViewModel vm) {
    return LunarCalendarPicker(
      icon: null,
      initialSolarDate: vm.solarDate,
      dateText: "Xem Thêm",
      onDateSelected: (solar, lunarDate) async {
        vm.setDate(solar, lunarDate);
        await vm.loadDate(solar);
      },
      showLunarDate: true,
    );
  }

  Widget _buildChiTietNgayAmLich(DashboardViewModel vm) {
    return Text(vm.todayData?.lichDuongThu ?? "");
  }
}
