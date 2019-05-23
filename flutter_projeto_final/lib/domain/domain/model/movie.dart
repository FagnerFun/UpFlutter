
class Movie
{
  int id;
  String title;
  String overview;
  String poster_path;
  String backdrop_path;
  double vote_average;

  Movie(this.title, this.overview, this.poster_path, this.vote_average, this.backdrop_path, this.id);


  Movie.fromJson(Map<String, dynamic> json)  :
        title = json["title"],
        poster_path =  json["poster_path"],
        backdrop_path = json["backdrop_path"] != null ?  json["backdrop_path"].toString() : null,
        vote_average = json["vote_average"] == null ? 0 : double.parse(json["vote_average"].toString()),
        overview = json["overview"],
        id = json["id"] as int;

  Map toMap() {
    Map<String,dynamic> map = {
      "title": title,
      "poster_path": poster_path,
      "backdrop_path": backdrop_path,
      "overview": overview,
      "vote_average": vote_average
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

}

