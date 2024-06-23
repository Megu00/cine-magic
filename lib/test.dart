import 'dart:convert';

import 'package:cine_magic/constances.dart';

import 'package:cine_magic/servises/tv_servises.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Test extends StatelessWidget {
  Test({super.key});
  final TvServises _tvServises = TvServises();
  Future<Map> getSeasonEpisodes() async {
    Map<String, dynamic> episodes = {};
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/search/multi?query=Jack&$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        episodes = data;
      }
    } catch (e) {
      print(e);
    }
    return episodes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getSeasonEpisodes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }
        if (snapshot.hasData) {
          Map? search = snapshot.data;
          return Center(
            child: Text(search!['results'].toString()),
          );
        }
        return Container(
          color: Colors.red,
        );
      },
    ));
  }
}
