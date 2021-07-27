class NowPlayingModel {
  int page;
  DatesData dates;
  List<ResultData> results = [];

  NowPlayingModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    dates = json['dates'] != null ? DatesData.fromJson(json['dates']) : null;
    json['results'].forEach((element) {
      results.add(ResultData.fromJson(element));
    });
  }
}

class DatesData {
  String maximum;
  String minimum;

  DatesData.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }
}

class ResultData {
  bool adult;
  String backdropPath;
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
  List<int> genreIds;

  ResultData.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath =  'https://image.tmdb.org/t/p/original/${json['backdrop_path']}';
    posterPath = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    title = json['title'];
    video = json['video'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    genreIds = json['genre_ids'].cast<int>();
  }
}
