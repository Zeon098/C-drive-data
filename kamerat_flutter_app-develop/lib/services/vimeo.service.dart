import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VimeoService {
  static final VimeoService _instance = VimeoService._internal();
  VimeoService._internal();
  factory VimeoService() => _instance;

  final String _videoBaseUrl = 'https://api.vimeo.com';
  final String _vimeoAccessToken = dotenv.env['VIMEO_ACCESS_TOKEN'] ?? '';

  Future<http.Response> getVideoDetails({required String videoUri}) {
    final String uri = '$_videoBaseUrl$videoUri/?fields=play,name,description';

    return http.get(
      Uri.parse(uri),
      headers: {
        'Authorization': 'bearer $_vimeoAccessToken',
        'Accept': 'application/vnd.vimeo.*+json;version=3.4'
      },
    );
  }
}
