import 'package:cine_magic/constances.dart';

import 'package:cine_magic/presentation/tvshows/onthAir_Tv.dart';

import 'package:cine_magic/presentation/tvshows/popular_tv.dart';
import 'package:cine_magic/presentation/tvshows/topRated_tv.dart';

import 'package:cine_magic/widgest/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TvShowView extends ConsumerWidget {
  const TvShowView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final AsyncValue<List<TvShow>> popular = ref.watch(populatTvProvider);
    // final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          backgroundColor: backgroundcolor,
          title: CustomText(
            text: 'Tv Shows',
            fontWeight: FontWeight.bold,
            size: 18.sp,
            color: Colors.white,
          ),
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.white,
            automaticIndicatorColorAdjustment: true,
            tabs: <Widget>[
              Tab(
                  icon: CustomText(
                text: 'Popular',
                fontWeight: FontWeight.bold,
                size: 18.sp,
                color: Colors.white,
              )),
              Tab(
                  icon: CustomText(
                text: 'Top Rated',
                fontWeight: FontWeight.bold,
                size: 18.sp,
                color: Colors.white,
              )),
              Tab(
                  icon: CustomText(
                text: 'Today',
                fontWeight: FontWeight.bold,
                size: 18.sp,
                color: Colors.white,
              )),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[PopularTv(), TopRatedTv(), ONTheAirTv()],
        ),
      ),
    );
  }
}
