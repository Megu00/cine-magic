import 'package:cine_magic/presentation/Movies/now_widget.dart';
import 'package:cine_magic/presentation/Movies/topRared_view.dart';

import 'package:cine_magic/providers/api_providers.dart';

import 'package:cine_magic/widgest/custom_text.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/movie.dart';

import 'popular_view.dart';

class MoviesView extends ConsumerWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Movie>> popular = ref.watch(popularMoviesProvider);

    final Size size = MediaQuery.of(context).size;
    return popular.when(
        data: (popular) => Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: SizedBox.expand(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ListView(
                        children: [
                          NowView(size: size),
                          PopularView(
                              heigth: size.height,
                              width: size.width,
                              popular: popular),
                          TopRatedView(size: size),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        error: (err, stack) {
          return Center(
            child: CustomText(text: err.toString()),
          );
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
