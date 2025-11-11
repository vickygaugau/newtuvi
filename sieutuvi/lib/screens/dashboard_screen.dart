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
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DashboardViewModel>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildTopSection(),
              const SizedBox(height: 16),
              _buildPageView(),
              const SizedBox(height: 16),
              _buildMiddleSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _square(double size, {String? label}) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ],
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

  Widget _buildTopSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                AppAssets.iconHistory,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
            const Text("TextT", style: TextStyle(fontSize: 16)),
            _square(40),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _square(60),
            Column(
              children: [
                _square(60),
                const SizedBox(height: 4),
                const Text("Text"),
              ],
            ),
            _square(60),
          ],
        ),
        const SizedBox(height: 12),
        _square(40),
      ],
    );
  }

  Widget _buildMiddleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _square(40),
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
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 5; i++) i == 2 ? _square(40) : _square(30),
        ],
      ),
    );
  }
}
