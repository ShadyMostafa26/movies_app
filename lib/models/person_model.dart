class PersonModel {
List<PersonResults> results = [];

  PersonModel.fromJson(Map<String, dynamic> json){

    json['results'].forEach((element) {
      results.add(PersonResults.fromJson(element));
    });
  }
}

class PersonResults{
  String profilePath;
  int id;
  String name;

  PersonResults.fromJson(Map<String, dynamic> json){
    profilePath = 'https://image.tmdb.org/t/p/original/${json['profile_path']}';
    id = json['id'];
    name = json['name'];
  }
}
