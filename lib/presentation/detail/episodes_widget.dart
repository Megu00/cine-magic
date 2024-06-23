import 'package:cine_magic/models/season.dart';
import 'package:cine_magic/models/season_filter.dart';
import 'package:cine_magic/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EpisodesView extends ConsumerWidget {
  const EpisodesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<TvSeason> tvSeason = ref.watch(
        tvSeasonProvider(TvSeasonFilter(tvSeriesId: 11366, seasonNumber: 1)));
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200.h,
      width: size.width,
      child: tvSeason.when(
        data: (data) {
          return Center(
            child: Text('${data.episodes!.length}'),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('$error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
