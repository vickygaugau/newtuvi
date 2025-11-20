import 'package:flutter/material.dart';
import 'package:lunar_calendar_plus/lunar_calendar.dart';
import 'package:provider/provider.dart';
import 'package:sieutuvi/AI/chat_page.dart';
import 'package:sieutuvi/screens/user_info_page.dart';
import '../values/app_assets.dart';
import '../values/moon_phase/moon_phase_widget.dart';
import '../values/utils.dart';
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
      drawer: _buildLeftMenu(),
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
              Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: SvgPicture.asset(
                      AppAssets.iconHistory,
                      width: 32,
                      height: 32,
                      fit: BoxFit.fill,
                      color: Colors.white,
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                child: Image.asset(
                  AppAssets.iconThayDo,
                  width: 32,
                  height: 32,
                  fit: BoxFit.fill,
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
                  // Customize display
                  LunarCalendarPicker(
                    initialSolarDate: DateTime.now(),
                    onDateSelected: (solarDate, lunarDate) {
                      viewModel.setDate(solarDate, lunarDate);
                      viewModel.loadDate(solarDate);
                    },
                    dateText: viewModel.solarDate.day.toString(),
                    textStyle: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: null,
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
              width: 80,
              height: 80,
              Utils.getImage12congiap(
                viewModel.todayData?.lichDuongImage ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Container(
      height: 200,
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch, // hoặc start
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildEnhancedAnimatedMoonFromDate(DateTime.now()),
                      Text(
                        viewModel.todayData?.lichAmNgay ?? "",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2, // giảm khoảng cách dòng
                        ),
                      ),
                      const Text(
                        "GIỜ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        Utils.getCurrentTime24h(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 24),
                Container(color: Colors.white, width: 1),
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
          ),
        ),
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

  Widget _buildLeftMenu() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Thêm dòng này
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Người dùng",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "user@email.com",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // Menu items
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // đóng drawer
                // Xử lý khi click, ví dụ push trang khác
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserInfoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
