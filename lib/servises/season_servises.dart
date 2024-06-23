import 'dart:convert';

import 'package:cine_magic/constances.dart';

import 'package:cine_magic/models/season.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class SeasonServises {
  Future<TvSeason> getSeasonEpisodes(int tvSeriesId, int seasonNumber) async {
    late TvSeason tvseason;
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/tv/$tvSeriesId/season/$seasonNumber?$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        tvseason = TvSeason.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return tvseason;
  }
}
