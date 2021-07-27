class MovieDetailModel{
  bool adult;
  int budget;
  String releaseDate;
  String originalTitle;
  int revenue;
  int runtime;
  List<GenreList> genres = [];

  MovieDetailModel.fromJson(Map<String,dynamic> json){
    adult = json['adult'];
    budget = json['budget'];
    releaseDate = json['release_date'];
    originalTitle = json['original_title'];
    revenue = json['revenue'];
    runtime = json['runtime'];

    json['genres'].forEach((element) {
      genres.add(GenreList.fromJson(element));
    });
  }
}

class GenreList{
  int id;
  String name;

  GenreList.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}