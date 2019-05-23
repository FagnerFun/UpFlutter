import 'dart:convert';

import 'package:flutter_projeto_final/domain/domain/Infra/AppSettings.dart';
import 'package:flutter_projeto_final/domain/domain/Infra/movieDao.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_projeto_final/domain/domain/model/movie.dart';

class MovieService {
  static Future<List<Movie>> getMovies() async {

    final response = await http.get(AppSettings.ApiUrl);

    final mapMovies = json.decode(response.body)["results"];

    List<Movie> movies =
    mapMovies.map<Movie>((json) => Movie.fromJson(json)).toList();

    return movies;
  }

  static Future<List<Movie>> getFavoriteMovies() async {
    final db = MovieDAO.getInstance();
    return db.getMovies();
  }

  static Future<bool> hasMovie(Movie movie)
  async {
    return await MovieDAO.getInstance().exists(movie);
  }


}
