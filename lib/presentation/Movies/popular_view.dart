// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_magic/presentation/detail/movie_detail.dart';
import 'package:cine_magic/search/search_view.dart';

import 'package:cine_magic/widgest/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/movie.dart';

class PopularView extends StatefulWidget {
  const PopularView(
      {super.key,
      required this.heigth,
      required this.width,
      required this.popular});
  final double heigth;
  final double width;
  final List<Movie> popular;

  @override
  State<PopularView> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<PopularView> {
  bool isanimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isanimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> popular = widget.popular;
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
              text: 'Popular',
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
          height: 6.h,
        ),
        SizedBox(
            height: widget.heigth / 3,
            width: widget.width,
            child: ListView.builder(
              itemCount: popular.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(movie: popular[index]),
                        ));
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    height: 160.h,
                    width: 130.w,
                    curve: Curves.decelerate,
                    transform: Matrix4.translationValues(
                        isanimate ? 0 : widget.width, 0, 0),
                    duration: const Duration(milliseconds: 1800),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.h),
                          child: CachedNetworkImage(
                            height: 170.h,
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500/${popular[index].backdropPath}',
                            placeholder: (context, url) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade100,
                                  highlightColor: Colors.grey.shade50,
                                  child: const SizedBox());
                            },
                          ),
                        ),
                        CustomText(
                          size: 15.sp,
                          text: popular[index].title,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }
}
