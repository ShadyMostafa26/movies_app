class TrendingMovies{
  List<TrendingMoviesResult> results = [];

  TrendingMovies.fromJson(Map<String,dynamic> json){
    json['results'].forEach((element) {
      results.add(TrendingMoviesResult.fromJson(element));
    });
  }
}

class TrendingMoviesResult{
  int id;
  String backDrop;
  String originalTitle;
  String title;
  String posterPath;
  dynamic voteAverage;

  TrendingMoviesResult.fromJson(Map<String,dynamic> json){
    id = json['id'];
    backDrop = 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    originalTitle = json['original_title'];
    title = json['title'];
    posterPath = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
    voteAverage = json['vote_average'];
  }
}