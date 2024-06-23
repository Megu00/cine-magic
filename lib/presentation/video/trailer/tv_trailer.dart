// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cine_magic/constances.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TraillerView extends StatefulWidget {
  const TraillerView({
    super.key,
    required this.traillerLink,
  });
  final String traillerLink;
  @override
  State<TraillerView> createState() => _TraillerViewState();
}

class _TraillerViewState extends State<TraillerView> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.traillerLink,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundcolor,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            progressColors: const ProgressBarColors(
              playedColor: redColor,
            ),
            controller: _controller,
          ),
          builder: (contex, player) {
            return SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.h,
                      )),
                  Expanded(
                    child: player,
                  )
                ],
              ),
            );
          },
        ));
  }
}
