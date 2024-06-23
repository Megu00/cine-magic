import 'package:card_swiper/card_swiper.dart';
import 'package:cine_magic/presentation/detail/movie_detail.dart';
import 'package:cine_magic/search/search_view.dart';
import 'package:cine_magic/widgest/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/movie.dart';

import '../../providers/api_providers.dart';

class NowView extends ConsumerWidget {
  const NowView({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Movie>> now = ref.watch(nowMoviesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 7.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: CustomText(
                text: 'Now',
                size: 21.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MultipleSearch());
                },
                icon: Icon(
                  Icons.search,
                  size: 30.h,
                  color: Colors.white,
                ))
          ],
        ),
        SizedBox(
            height: 200.h,
            width: double.infinity,
            child: switch (now) {
              AsyncError(:final error) => Center(child: Text('Error: $error')),
              AsyncData(:final value) => Swiper(
                  curve: Curves.linear,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MovieDetail(movie: value[index]);
                          },
                        ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.h),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${value[index].backdropPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  itemCount: value.getRange(0, 9).toList().length,
                  pagination: const SwiperPagination(),
                  indicatorLayout: PageIndicatorLayout.COLOR,
                ),
              _ => const Center(
                  child: CircularProgressIndicator(),
                )
            })
      ],
    );
  }
}
