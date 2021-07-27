class SearchModel{
  List<SearchResult> results = [];

  SearchModel.fromJson(Map<String,dynamic> json){
   json['results'].forEach((element) {
     results.add(SearchResult.fromJson(element));
   });
  }
}

class SearchResult{
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  dynamic popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  dynamic voteAverage;
  int voteCount;
  String backdropPath;


  SearchResult.fromJson(Map<String,dynamic> json){
    id = json['id'];
    posterPath = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
    overview = json['overview'];
    popularity = json['popularity'];
    title = json['title'];
    video = json['video'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    voteAverage = json['vote_average'];
    backdropPath = 'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
  }

}