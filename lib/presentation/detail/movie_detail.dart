// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/config/gendres.dart';
import 'package:cine_magic/config/list_gendre.dart';
import 'package:cine_magic/constances.dart';
import 'package:cine_magic/models/movie.dart';
import 'package:cine_magic/presentation/detail/similar_movie.dart';
import 'package:cine_magic/presentation/video/loading_movie.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cine_magic/widgest/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetail extends ConsumerWidget {
  const MovieDetail({super.key, required this.movie});
  final Movie movie;
  List<Gendre> getgendreList(
    List<int>? avialablegendre,
  ) {
    List<Gendre> filterGendre = [];
    for (var id in avialablegendre!) {
      filterGendre += gendre.where((element) => element.id == id).toList();
    }

    return filterGendre;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: SizedBox.expand(
          child: ListView(
            children: [
              Container(
                  height: size.height / 3.3,
                  width: size.width,
                  color: Colors.amber,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500/${movie.backdropPath}",
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.grey.shade50,
                            child: const FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(),
                            )),
                      ),
                      Positioned(
                          top: 22.h,
                          left: 11.w,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30.h,
                              ))),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_arrow_rounded,
                              size: 60.h,
                              color: redColor,
                            )),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 7.w, top: 7.h),
                child: CustomText(
                  text: movie.title,
                  size: 21.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getgendreList(movie.genreIds).length,
                  itemBuilder: (context, index) {
                    final moviesGendres = getgendreList(movie.genreIds);
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        moviesGendres[index].name,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    CustomText(
                      color: Colors.white,
                      size: 20.sp,
                      text:
                          '${movie.voteAverage.toString().substring(0, 3)}/10',
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: movie.releaseDate,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    CustomText(
                      text: movie.adult == true ? '+18' : '',
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 65.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Center(
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadingTraillerMovie(
                                        videoId: movie.id))),
                            child: CustomText(
                              text: 'Trailller',
                              fontWeight: FontWeight.bold,
                              size: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: CustomText(
                  text: 'OverView',
                  color: redColor,
                  size: 20.sp,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: SizedBox(
                    height: 150.h,
                    width: size.width,
                    child: ListView(
                      children: [
                        CustomText(
                          text: movie.overview,
                          color: Colors.white,
                          size: 21.sp,
                        ),
                      ],
                    ),
                  )),
              SimilarMovie(
                movieId: movie.id,
              )
            ],
          ),
        ));
  }
}
