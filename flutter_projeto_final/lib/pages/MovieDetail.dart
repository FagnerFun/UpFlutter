

import 'package:flutter/material.dart';
import 'package:flutter_projeto_final/domain/domain/Infra/AppSettings.dart';
import 'package:flutter_projeto_final/domain/domain/Infra/movieDao.dart';
import 'package:flutter_projeto_final/domain/domain/model/movie.dart';
import 'package:flutter_projeto_final/domain/domain/services/movieService.dart';

class MovieDetailPage extends StatefulWidget {

  Movie movie;
  MovieDetailPage(this.movie);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text(widget.movie.title),
        ),
        backgroundColor: Colors.grey[350],
        body: _body(),
      );
  }

  @override
  void initState() {
    super.initState();

    MovieService.hasMovie(widget.movie).then((b){
      setState(() {
        _isFavorite = b;
      });
    });
  }
  bool _isFavorite = false;

  _body()
  {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black45,
          centerTitle: false,
          expandedHeight: 250,
          leading: Container(),
          floating: false,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            background: Image.network(
                widget.movie.backdrop_path == null ? "https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png" : AppSettings.ApiImageHighBaseUrl + widget.movie.backdrop_path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon( widget.movie.vote_average > 2 ? Icons.star :Icons.star_border , size: 30, color: widget.movie.vote_average > 2 ?  Colors.amber[400] : Colors.grey[700] ,) ,
                                    Icon( widget.movie.vote_average > 4 ? Icons.star :Icons.star_border , size: 30, color: widget.movie.vote_average > 4 ?  Colors.amber[400] : Colors.grey[700] ,) ,
                                    Icon( widget.movie.vote_average > 6 ? Icons.star :Icons.star_border , size: 30, color: widget.movie.vote_average > 6 ?  Colors.amber[400] : Colors.grey[700] ,) ,
                                    Icon( widget.movie.vote_average > 8 ? Icons.star :Icons.star_border , size: 30, color: widget.movie.vote_average > 8 ?  Colors.amber[400] : Colors.grey[700] ,) ,
                                    Icon( widget.movie.vote_average > 9 ? Icons.star :Icons.star_border , size: 30, color: widget.movie.vote_average > 9 ?  Colors.amber[400] : Colors.grey[700] ,) ,
                                  ],
                                ),
                              ),
                              InkWell(
                                  onTap: (){ _onClickFavorite(context,widget.movie);},
                                  child: Icon(Icons.favorite, color: _isFavorite ? Colors.red : Colors.grey[700], size: 30  ,)
                              )
                            ],
                          ),
                          Divider(color: Colors.black45),
                          Text(
                            widget.movie.overview,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onClickFavorite(BuildContext context, Movie movie) async {
      final db = MovieDAO.getInstance();
      final exists = await db.exists(movie);

      if(exists) {
        db.deleteMovie(movie.id);
      } else {
        int id = await db.saveMovie(movie);

        print("Carro salvo $id");
      }

      setState(() {
        _isFavorite = !exists;
      });
  }
}