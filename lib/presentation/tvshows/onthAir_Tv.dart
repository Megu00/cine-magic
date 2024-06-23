import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cine_magic/models/tv_show.dart';
import 'package:cine_magic/providers/api_providers.dart';
import 'package:cine_magic/widgest/custom_text.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ONTheAirTv extends ConsumerWidget {
  const ONTheAirTv({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TvSeries>> onTheAir = ref.watch(onTheAirTvprovider);
    int currentIndexProvider = ref.watch(currentindeximage);
    return onTheAir.when(
      data: (data) => Stack(
        children: [
          Stack(
            children: [
              Image.network(
                height: MediaQuery.of(context).size.height / 2.7,
                "https://image.tmdb.org/t/p/w500/${data[currentIndexProvider].backdropPath}",
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade200.withOpacity(0.3),
                  child: Center(
                    child: CustomText(
                      text: data[currentIndexProvider].name,
                      fontWeight: FontWeight.bold,
                      size: 20.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 210.h,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.grey.shade50.withOpacity(0.1),
                    Colors.grey.shade50.withOpacity(0.1),
                    Colors.grey.shade50.withOpacity(0.2),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade100.withOpacity(0.1)
                  ])),
              height: 90,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
              bottom: 25.h,
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                height: 250.h,
                child: CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      ref.read(currentindeximage.notifier).state = index;
                    },
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: data
                      .map((e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://image.tmdb.org/t/p/w500/${e.backdropPath}",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )))
                      .toList(),
                ),
              )),
        ],
      ),
      error: (error, stackTrace) => Center(
        child: Text("$error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

final currentindeximage = StateProvider<int>((ref) => 0);
