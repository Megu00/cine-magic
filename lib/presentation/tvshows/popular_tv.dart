import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/constances.dart';
import 'package:cine_magic/presentation/detail/tvdetail_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';

import '../../models/tv_show.dart';
import '../../providers/api_providers.dart';
import '../../widgest/custom_text.dart';

class PopularTv extends ConsumerWidget {
  const PopularTv({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TvSeries>> popular = ref.watch(populatTvProvider);
    return popular.when(error: (error, stackTrace) {
      return Center(
          child: CustomText(
        text: '$error',
        size: 21.sp,
        fontWeight: FontWeight.bold,
      ));
    }, loading: () {
      return const SizedBox.expand(
        child: Center(child: CircularProgressIndicator()),
      );
    }, data: (data) {
      List<TvSeries> tvs = data.where((element) {
        return element.backdropPath != null && element.backdropPath!.isNotEmpty;
      }).toList();
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 5.h),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: tvs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.w,
                  mainAxisExtent: 250.h,
                  mainAxisSpacing: 7.w),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TvDetailView(tvSeries: tvs[index])));
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.h)),
                      color: backgroundcolor.withOpacity(1),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 190.h,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.h),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/${tvs[index].backdropPath}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Shimmer.fromColors(
                                          baseColor: Colors.grey.shade100,
                                          highlightColor: Colors.grey.shade50,
                                          child: Container());
                                    },
                                  ))),
                          CustomText(
                            text: tvs[index].name,
                            color: Colors.white,
                            size: 17.sp,
                          )
                        ],
                      )),
                );
              },
            )),
      );
    });
  }
}
