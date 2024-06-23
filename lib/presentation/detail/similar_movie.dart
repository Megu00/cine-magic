// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/models/movie.dart';
import 'package:cine_magic/presentation/detail/movie_detail.dart';
import 'package:cine_magic/providers/api_providers.dart';
import 'package:cine_magic/widgest/custom_text.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SimilarMovie extends ConsumerWidget {
  const SimilarMovie({
    super.key,
    required this.movieId,
  });
  final int movieId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Movie>> SimilarMovie =
        ref.watch(similarProvider(movieId));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
          height: 150.h,
          width: double.infinity,
          child: SimilarMovie.when(
              data: (data) {
                return data.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Similar',
                            fontWeight: FontWeight.bold,
                            size: 16.sp,
                            color: Colors.white,
                          ),
                          SizedBox(
                              height: 120.h,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length > 3
                                    ? data.getRange(0, 3).toList().length
                                    : data.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return MovieDetail(
                                            movie: data[index],
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                        height: 150.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        width: 100.w,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.h),
                                              child: CachedNetworkImage(
                                                height: 120.h,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500/${data[index].backdropPath}',
                                                placeholder: (context, url) {
                                                  return Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey.shade100,
                                                      highlightColor:
                                                          Colors.grey.shade50,
                                                      child: const SizedBox());
                                                },
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.w),
                                              children: [
                                                CustomText(
                                                  text: data[index].title,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ))
                                          ],
                                        )),
                                  );
                                },
                              )),
                        ],
                      )
                    : const SizedBox(
                        child: Center(
                        child: Text('Nooo ate'),
                      ));
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text('$error'),
                );
              },
              loading: () => Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                  child: const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  )))),
    );
  }
}
