import 'package:cine_magic/constances.dart';

import 'package:cine_magic/presentation/Movies/movies_view.dart';

import 'package:cine_magic/presentation/navigation/bottom_nav.dart';
import 'package:cine_magic/presentation/tvshows/tvshow_view.dart';

import 'package:flutter/material.dart';

class ScreenNav extends StatefulWidget {
  ScreenNav({super.key});

  @override
  State<ScreenNav> createState() => _ScreenNavState();
}

class _ScreenNavState extends State<ScreenNav> {
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavApp(
        pageController: _pageController,
      ),
      backgroundColor: backgroundcolor,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: const [
          MoviesView(),
          TvShowView(),
        ],
      ),
      // <--- do not forget mark this as true
    );
  }
}
