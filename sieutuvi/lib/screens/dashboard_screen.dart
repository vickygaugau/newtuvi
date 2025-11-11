import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';
import 'package:provider/provider.dart';
import '../values/app_assets.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(DashboardViewModel vm) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
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
                ),
              ),
              Text(
                viewModel.todayData?.lichDuongThu ?? "",
                style: TextStyle(
                  fontSize: 18,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Container(color: Colors.cyan, width: 60, height: 60),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      viewModel.solarDate.day.toString(),
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text("Text"),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(color: Colors.cyan, width: 60, height: 60),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            child: Container(color: Colors.cyan, width: 60, height: 60),
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
}
