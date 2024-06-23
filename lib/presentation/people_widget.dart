// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cine_magic/widgest/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({
    super.key,
    required this.width,
  });
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150.h,
        width: width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.h),
                      image: const DecorationImage(
                          image: AssetImage('assests/images/ema.jpg'),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomText(
                  text: 'User Name',
                  size: 18.sp,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ));
  }
}
