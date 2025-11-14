import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';
import 'package:provider/provider.dart';
import '../values/app_assets.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DashboardViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<DashboardViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashboardViewModel>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset(AppAssets.bg, fit: BoxFit.cover)),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.1)),
          ),
          Column(
            children: [
              const SizedBox(height: 16),
              _buildTopSection(vm),
              const SizedBox(height: 16),
              _buildPageView(),
              const SizedBox(height: 16),
              _buildMiddleSection(),
              Spacer(),
              _buildBottomBar(),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (_, index) {
          switch (index) {
            case 0:
              return _buildPageLoiHayYDep();
            case 1:
              return _buildPageLoiHayYDep();
            case 2:
              return _buildPageLoiHayYDep();
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildTopSection(DashboardViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          // + Thứ 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppAssets.iconHistory,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
              Text(
                viewModel.todayData?.lichDuongThu ?? "",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  AppAssets.iconPlus,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Icon Ngày Tháng Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  AppAssets.iconSun,
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      viewModel.solarDate.day.toString(),
                      style: TextStyle(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    viewModel.getThangNamString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  AppAssets.iconSun,
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            child: Image.asset(
              AppAssets.iconConGiap,
              fit: BoxFit.contain,
              width: 70,
              height: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(color: Colors.cyan, width: 60, height: 60),
              ),
              const SizedBox(height: 6),
              const Text("Text"),
              const Text("Text"),
              const Text("Text"),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Text"),
                SizedBox(height: 6),
                Text("Text"),
                SizedBox(height: 6),
                Text("Text"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 5; i++)
            i == 2
                ? InkWell(
                    onTap: () {},
                    child: Container(color: Colors.cyan, width: 60, height: 60),
                  )
                : InkWell(
                    onTap: () {},
                    child: Container(color: Colors.cyan, width: 60, height: 60),
                  ),
        ],
      ),
    );
  }

  Widget _buildPageLoiHayYDep() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          viewModel.listLoiHayYDep[Random().nextInt(
            viewModel.listLoiHayYDep.length,
          )],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
