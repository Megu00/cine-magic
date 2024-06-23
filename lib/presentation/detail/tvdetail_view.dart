// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cine_magic/presentation/video/loading_tv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/constances.dart';
import 'package:cine_magic/models/season.dart';
import 'package:cine_magic/models/season_filter.dart';
import 'package:cine_magic/models/tv_details.dart';

import 'package:cine_magic/providers/api_providers.dart';

import 'package:cine_magic/widgest/custom_text.dart';

import 'package:flutter/material.dart';

import 'package:cine_magic/models/tv_show.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TvDetailView extends ConsumerWidget {
  const TvDetailView({
    super.key,
    required this.tvSeries,
  });
  final TvSeries tvSeries;

  Future openlink(String link) async {
    await launchUrl(Uri.parse(link));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final AsyncValue<TvDetail> tvdetails =
        ref.watch(tvDetailsProvider(tvSeries.id!));
    final AsyncValue<TvSeason> tvSeason = ref.watch(tvSeasonProvider(
        TvSeasonFilter(tvSeriesId: tvSeries.id!, seasonNumber: 1)));
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: tvdetails.when(
            data: (data) {
              return SizedBox.expand(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: 200.h,
                            width: size.width,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${tvSeries.backdropPath}',
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            },
                            placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade50,
                                child: const SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                ))),
                        Positioned(
                            top: 13.h,
                            left: 10.w,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 28.h,
                                  color: Colors.white,
                                )))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: CustomText(
                        text: '${tvSeries.name}',
                        size: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                                '${tvSeries.voteAverage.toString().substring(0, 3)}/10',
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
                            text: '${tvSeries.id}',
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          CustomText(
                            text: tvSeries.adult == true ? '+18' : '',
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return LoadingTraillerTV(
                                      videoId: tvSeries.id!);
                                },
                              ));
                            },
                            child: Container(
                              width: 65.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade400,
                                  borderRadius: BorderRadius.circular(15.h)),
                              child: Center(
                                child: InkWell(
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
                    SizedBox(
                      height: 120.h,
                      width: size.width,
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 3.h),
                        children: [
                          CustomText(
                            text: '${tvSeries.overview}',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: tvdetails.when(
                          data: (data) {
                            return Row(
                              children: [
                                CustomText(
                                  text:
                                      'Season ${data.seasons![0].seasonNumber}',
                                  color: Colors.white,
                                  size: 19.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                  size: 38.h,
                                )
                              ],
                            );
                          },
                          error: (error, stackTrace) => CustomText(
                            text: '$error',
                            fontWeight: FontWeight.bold,
                            size: 20.sp,
                          ),
                          loading: () => const SizedBox(),
                        )),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: CustomText(
                text: '$error',
                size: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          )),
    );
  }
}
