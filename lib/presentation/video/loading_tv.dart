import 'package:cine_magic/presentation/video/trailer/tv_trailer.dart';
import 'package:cine_magic/providers/api_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingTraillerTV extends ConsumerWidget {
  const LoadingTraillerTV({super.key, required this.videoId});
  final int videoId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailler = ref.watch(traillerTvLinkProvider(videoId));
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
