import 'package:cine_magic/models/search.dart';
import 'package:cine_magic/models/season.dart';
import 'package:cine_magic/models/season_filter.dart';
import 'package:cine_magic/models/trailler.dart';
import 'package:cine_magic/models/tv_details.dart';
import 'package:cine_magic/models/tv_show.dart';
import 'package:cine_magic/servises/movies_servises.dart';
import 'package:cine_magic/servises/search_servises.dart';
import 'package:cine_magic/servises/season_servises.dart';
import 'package:cine_magic/servises/tv_servises.dart';
import 'package:cine_magic/servises/video_servises.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie.dart';

final MovieServises _movieServises = MovieServises();
final TvServises _tvServises = TvServises();
final VideoServises _videoServises = VideoServises();
final SeasonServises _seasonServises = SeasonServises();
final popularMoviesProvider = FutureProvider<List<Movie>>(
    (ref) async => _movieServises.getpopularMovie());

final SearchServises _searchServises = SearchServises();

final nowMoviesProvider = FutureProvider((ref) => _movieServises.getnowMovie());

final topratedMoviesProvider =
    FutureProvider<List<Movie>>((ref) => _movieServises.gettopratedMovies());

final populatTvProvider =
    FutureProvider<List<TvSeries>>((ref) => _tvServises.getPopularTv());
final topRatedTvProvider =
    FutureProvider<List<TvSeries>>((ref) => _tvServises.getTopRatedTv());
final onTheAirTvprovider =
    FutureProvider<List<TvSeries>>((ref) => _tvServises.getOnTheAirTv());

final traillerProvider = FutureProviderFamily<Trailler, int>(
    (ref, arg) => _videoServises.getMovieTraillerLink(arg));

final similarProvider = FutureProviderFamily<List<Movie>, int>(
    (ref, arg) => _movieServises.getsimilarmovie(arg));

final tvTraillerProvider = FutureProviderFamily<Trailler, int>(
    (ref, arg) => _videoServises.geTvTraillerLink(arg));

final tvDetailsProvider = FutureProviderFamily<TvDetail, int>(
    (ref, arg) => _tvServises.getTvDetails(arg));

final tvSeasonProvider = FutureProviderFamily<TvSeason, TvSeasonFilter>(
    (ref, arg) =>
        _seasonServises.getSeasonEpisodes(arg.tvSeriesId, arg.seasonNumber));

final searchProvider = FutureProviderFamily<List<Search>, String>(
    (ref, arg) => _searchServises.getMultiplesearch(arg));

final traillerTvLinkProvider = FutureProviderFamily<Trailler, int>(
    (ref, arg) => _videoServises.geTvTraillerLink(arg));
