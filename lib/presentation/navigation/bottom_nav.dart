import 'package:cine_magic/constances.dart';
import 'package:cine_magic/providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNavApp extends ConsumerWidget {
  const BottomNavApp({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomIndexProfider);
    return SlidingClippedNavBar(
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
      inactiveColor: Colors.white,
      backgroundColor: backgroundcolor,
      onButtonPressed: (index) {
        ref.read(bottomIndexProfider.notifier).state = index;
        pageController.jumpToPage(index);
      },
      iconSize: 27,
      activeColor: redColor,
      selectedIndex: index,
      barItems: [
        BarItem(
          icon: Icons.movie_creation,
          title: 'Movies',
        ),
        BarItem(
          icon: Icons.live_tv_sharp,
          title: 'Tv Shows',
        ),

        /// Add more BarItem if you want
      ],
    );
  }
}
