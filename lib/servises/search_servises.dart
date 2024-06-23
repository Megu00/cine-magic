import 'dart:convert';

import 'package:cine_magic/constances.dart';
import 'package:cine_magic/models/movie.dart';

import 'package:cine_magic/models/search.dart';
import 'package:cine_magic/models/tv_show.dart';
import 'package:cine_magic/presentation/detail/movie_detail.dart';

import 'package:cine_magic/presentation/detail/tvdetail_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SearchServises {
  Future<List<Search>> getMultiplesearch(String query) async {
    List<Search> search = <Search>[];
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/search/multi?query=$query&$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        for (var element in results) {
          search.add(Search.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return search;
  }

  navigatesearch(String mediatype, BuildContext context, Search resultsearch) {
    switch (mediatype) {
      case 'movie':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return MovieDetail(
                movie: Movie(
                    adult: resultsearch.adult ?? false,
                    backdropPath: resultsearch.backdropPath ?? '',
                    genreIds: resultsearch.genreIds ?? [],
                    id: resultsearch.id!,
                    title: resultsearch.title ?? '',
                    originalTitle: resultsearch.originalTitle ?? '',
                    releaseDate: resultsearch.releaseDate ?? '',
                    video: resultsearch.video ?? false,
                    overview: resultsearch.overview ?? '',
                    posterPath: resultsearch.posterPath ?? '',
                    popularity: resultsearch.popularity ?? 0.0,
                    voteAverage: resultsearch.voteAverage ?? 0,
                    voteCount: resultsearch.voteCount ?? 0,
                    originalLanguage: ''));
          },
        ));
        break;
      case 'tv':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return TvDetailView(
                tvSeries: TvSeries(
                    adult: resultsearch.adult,
                    backdropPath: resultsearch.backdropPath,
                    genreIds: resultsearch.genreIds,
                    id: resultsearch.id,
                    name: resultsearch.title,
                    mediaType: resultsearch.mediaType,
                    overview: resultsearch.overview,
                    posterPath: resultsearch.posterPath,
                    originalName: resultsearch.originalTitle,
                    popularity: resultsearch.popularity,
                    voteAverage: resultsearch.voteAverage,
                    voteCount: resultsearch.voteCount,
                    originCountry: [],
                    firstAirDate: '',
                    originalLanguage: ''));
          },
        ));
      case 'person':
        return;
    }
  }
}
