import 'package:flutter/material.dart';
import 'package:pomodo/Pages/home_page.dart';
import 'package:pomodo/Pages/settings_page.dart';

class Pageview extends StatefulWidget {
  const Pageview({super.key});

  @override
  State<Pageview> createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [HomePage(), SettingsPage()],
    );
  }
}
