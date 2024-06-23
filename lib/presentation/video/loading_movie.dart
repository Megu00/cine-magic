// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cine_magic/presentation/video/trailer/tv_trailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cine_magic/providers/api_providers.dart';

class LoadingTraillerMovie extends ConsumerWidget {
  const LoadingTraillerMovie({
    super.key,
    required this.videoId,
  });
  final int videoId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailler = ref.watch(traillerProvider(videoId));
    return trailler.when(
      data: (data) {
        return TraillerView(traillerLink: data.key);
      },
      error: (error, stackTrace) {
        return Center(
          child: Text('$error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
