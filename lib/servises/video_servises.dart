import 'dart:convert';

import 'package:cine_magic/constances.dart';

import 'package:cine_magic/models/trailler.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class VideoServises {
  Future<Trailler> getMovieTraillerLink(int movieID) async {
    late Trailler trailler;
    try {
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieID/videos?$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> results = data['results'];
        int traillerIndex =
            results.indexWhere((element) => element['type'] == 'Trailer');
        trailler = Trailler.fromJson(results[traillerIndex]);
        print('AAAAAAAAAAAAAAAAAA+${trailler.name}');
      }
    } catch (e) {
      print(e);
    }
    return trailler;
  }

  Future<Trailler> geTvTraillerLink(int tvId) async {
    late Trailler trailler;
    try {
      Uri url =
          Uri.parse("https://api.themoviedb.org/3/tv/$tvId/videos?$apikey");
      Response response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<dynamic> results = data['results'];
        int traillerIndex =
            results.indexWhere((element) => element['type'] == 'Trailer');
        trailler = Trailler.fromJson(results[traillerIndex]);
        print('AAAAAAAAAAAAAAAAAA+${trailler.name}');
      }
    } catch (e) {
      print(e);
    }
    return trailler;
  }
}
