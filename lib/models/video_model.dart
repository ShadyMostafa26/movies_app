class VideoModel{
  int id;
  List<VideoResult> results = [];

  VideoModel.fromJson(Map<String,dynamic> json){
    id = json['id'];

    json['results'].forEach((element) {
      results.add(VideoResult.fromJson(element));
    });
  }
}


class VideoResult{
  String id;
  String key;

  VideoResult.fromJson(Map<String,dynamic> json){
    id = json['id'];
    key = json['key'];
  }
}