import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/models/movie.dart';
import 'package:cine_magic/presentation/detail/movie_detail.dart';
import 'package:cine_magic/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgest/custom_text.dart';

class TopRatedView extends ConsumerStatefulWidget {
  const TopRatedView({super.key, required this.size});
  final Size size;
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<TopRatedView> {
  bool isanimate = false;
  @override
  void initState() {
    super.initState();
    ref.read(topratedMoviesProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isanimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Movie>> topRated = ref.watch(topratedMoviesProvider);

    return topRated.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 17.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Top Rated',
                    fontWeight: FontWeight.bold,
                    size: 21.sp,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'See More',
                    fontWeight: FontWeight.bold,
                    size: 19.sp,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                  height: widget.size.height / 4,
                  width: widget.size.width,
                  child: ListView.builder(
                    itemCount: topRated.value?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MovieDetail(movie: data[index]);
                            },
                          ));
                        },
                        child: AnimatedContainer(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            height: 130.h,
                            width: 130.w,
                            curve: Curves.decelerate,
                            transform: Matrix4.translationValues(
                                isanimate ? 0 : widget.size.width, 0, 0),
                            duration: const Duration(milliseconds: 1800),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.h),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${data[index].backdropPath}',
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade100,
                                      highlightColor: Colors.grey.shade50,
                                      child: const SizedBox());
                                },
                              ),
                            )),
                      );
                    },
                  ))
            ],
          );
        },
        error: (error, stackTrace) => Center(
              child: CustomText(
                text: '$error',
                size: 15.sp,
              ),
            ),
        loading: () => const SizedBox());
  }
}
