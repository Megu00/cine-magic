import 'dart:convert';

import 'package:cine_magic/constances.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/movie.dart';

class MovieServises {
  final String popularMovieLink =
      "https://api.themoviedb.org/3/movie/popular?$apikey";
  final String nowMovieLink =
      'https://api.themoviedb.org/3/movie/now_playing?$apikey';
  final String topRatedMovieLink =
      'https://api.themoviedb.org/3/movie/top_rated?$apikey';

  Future<List<Movie>> getpopularMovie() async {
    List<Movie> popular = [];
    try {
      Uri url = Uri.parse(popularMovieLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        for (var element in results) {
          popular.add(Movie.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return popular;
  }

  Future<List<Movie>> getnowMovie() async {
    List<Movie> now = <Movie>[];
    try {
      Uri url = Uri.parse(nowMovieLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        results.map((movie) => now.add(Movie.fromJson(movie))).toList();
      }
    } catch (e) {
      print(e);
    }
    return now;
  }

  Future<List<Movie>> gettopratedMovies() async {
    List<Movie> topRated = <Movie>[];
    try {
      Uri url = Uri.parse(topRatedMovieLink);
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        print(results);
        results.map((movie) => topRated.add(Movie.fromJson(movie))).toList();
      }
    } catch (e) {
      print(e);
    }
    return topRated;
  }

  Future<List<Movie>> getsimilarmovie(int movieId) async {
    List<Movie> similar = <Movie>[];
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/similar?$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> results = data['results'];
        results.map((movie) => similar.add(Movie.fromJson(movie))).toList();
      }
    } catch (e) {
      print(e);
    }
    return similar.where((element) => !element.video).toList();
  }
}


Future