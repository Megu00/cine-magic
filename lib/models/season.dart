import 'dart:ffi';

class TvSeason {
  List<Episodes>? episodes;
  String? name;
  TvSeason({this.episodes, this.name});
  TvSeason.fromJson(Map<String, dynamic> json) {
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(Episodes.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (episodes != null) {
      data['episodes'] = episodes!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    return data;
  }
}

class Episodes {
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  int? showId;
  Double? voteAverage;
  double? voteCount;

  Episodes({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.showId,
    this.voteAverage,
    this.voteCount,
  });

  Episodes.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    episodeType = json['episode_type'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    showId = json['show_id'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['episode_type'] = episodeType;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
