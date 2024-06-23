import 'package:cine_magic/servises/search_servises.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final SearchServises _searchServises = SearchServises();
final bottomIndexProfider = StateProvider<int>((ref) => 0);

final urlProvider = ProviderFamily<void, Uri>((ref, arg) => _launchUrl(arg));

Future<void> _launchUrl(Uri uri) async {
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
