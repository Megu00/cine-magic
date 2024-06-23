import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/constances.dart';
import 'package:cine_magic/models/search.dart';

import 'package:cine_magic/providers/api_providers.dart';
import 'package:cine_magic/servises/search_servises.dart';
import 'package:cine_magic/widgest/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MultipleSearch extends SearchDelegate {
  final SearchServises _searchServises = SearchServises();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(appBarTheme: const AppBarTheme());
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue<List<Search>> results =
            ref.watch(searchProvider(query));
        return results.when(
          data: (data) {
            List<Search> results = [];
            for (var element in data) {
              if (element.backdropPath != null &&
                  element.backdropPath!.isNotEmpty) {
                results.add(element);
              }
            }

            return GridView.builder(
              itemCount: results.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.w,
                  mainAxisExtent: 250.h,
                  mainAxisSpacing: 7.w),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _searchServises.navigatesearch(
                        results[index].mediaType!, context, results[index]);
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.h)),
                      color: backgroundcolor,
                      child: Column(
                        children: [
                          SizedBox(
                              height: 190.h,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.h),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/${results[index].backdropPath}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Shimmer.fromColors(
                                          baseColor: Colors.red,
                                          highlightColor: Colors.grey.shade50,
                                          child: Container());
                                    },
                                  ))),
                          Expanded(
                              child: ListView(
                            children: [
                              CustomText(
                                text: results[index].title.toString(),
                                color: Colors.white,
                                size: 17.sp,
                              )
                            ],
                          ))
                        ],
                      )),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
            child: Text('$error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }
}
