import 'package:flutter/material.dart';
import 'package:flutter_projeto_final/domain/domain/Infra/AppSettings.dart';
import 'package:flutter_projeto_final/domain/domain/model/movie.dart';
import 'package:flutter_projeto_final/domain/domain/services/movieService.dart';
import 'package:flutter_projeto_final/pages/MovieDetail.dart';
import 'package:flutter_projeto_final/utils/nav.dart';

class MoviesPage extends StatelessWidget {
  bool MyMovies = false;

  MoviesPage(this.MyMovies);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _gridBuilder(context),
    );
  }

  _gridBuilder(context) {
    Future<List<Movie>> movies;

    if(MyMovies)
      movies = MovieService.getFavoriteMovies();
    else
      movies = MovieService.getMovies();

    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Movie> movies = snapshot.data;
        return _gridView(context,movies);
      },
    );
  }


  _gridView(context, List<Movie> movies) {
    return GridView.builder(
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height,
      ),
      itemCount: movies.length,
      itemBuilder: (context, idx) {
        final movie = movies[idx];

        return GestureDetector(
          onTap: () => _onClickMovie(context, movie),
          child: Container(
            padding: EdgeInsets.all(5),
            color: Colors.grey[350],
            child: Image.network(
              movie.poster_path == null? "https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png" : AppSettings.ApiImageBaseUrl + movie.poster_path,
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  _onClickMovie(BuildContext context, Movie movie) {
    push(context, MovieDetailPage(movie));
  }

}
