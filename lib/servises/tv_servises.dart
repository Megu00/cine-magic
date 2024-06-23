import 'dart:convert';

import 'package:cine_magic/constances.dart';
import 'package:cine_magic/models/tv_details.dart';
import 'package:cine_magic/models/tv_show.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TvServises {
  final String PopularTvLink =
      'https://api.themoviedb.org/3/tv/popular?$apikey';

  final String topRatedTvLink =
      'https://api.themoviedb.org/3/tv/top_rated?$apikey';
  final String ontheAirTvLink =
      'https://api.themoviedb.org/3/tv/airing_today?$apikey';
  static const String tvVideoLink =
      'https://api.themoviedb.org/3/tv/{series_id}/videos';

  Future<List<TvSeries>> getPopularTv() async {
    List<TvSeries> tvshows = <TvSeries>[];
    try {
      Uri url = Uri.parse(PopularTvLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        print(results);
        results.map((movie) => tvshows.add(TvSeries.fromJson(movie))).toList();
      }
    } catch (e) {
      print(e);
    }
    return tvshows;
  }

  Future<List<TvSeries>> getTopRatedTv() async {
    List<TvSeries> topRated = <TvSeries>[];
    try {
      Uri url = Uri.parse(topRatedTvLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        print(results);
        results.map((movie) => topRated.add(TvSeries.fromJson(movie))).toList();
      }
    } catch (e) {
      print(e);
    }
    return topRated;
  }

  Future<List<TvSeries>> getOnTheAirTv() async {
    List<TvSeries> ontheAirTv = <TvSeries>[];
    try {
      Uri url = Uri.parse(PopularTvLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        print(results);
        results
            .map((movie) => ontheAirTv.add(TvSeries.fromJson(movie)))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return ontheAirTv;
  }

  Future<TvDetail> getTvDetails(int tvId) async {
    late TvDetail tvDetail;
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/tv/$tvId?$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        tvDetail = TvDetail.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return tvDetail;
  }
}
