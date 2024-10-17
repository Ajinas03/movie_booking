import 'package:http/http.dart' as http;
import 'package:movie_booking/model/movie_model.dart';

class MovieRepo {
  static Future<MovieModel?> getMovies() async {
    const String url = 'https://v2.sg.media-imdb.com/suggestion/h/hello.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return MovieModel.fromJson(response.body);
      } else {
        print('Failed to load movies: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching movies: $e');
      return null;
    }
  }
}
