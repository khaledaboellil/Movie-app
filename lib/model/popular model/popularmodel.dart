class PopularModel{


List<Data>results=[];

PopularModel.fromjson(Map<String,dynamic>json){
  json['results'].forEach((element){
    results.add(Data.fromjson(element));
  });

  }
}

class Data{
  dynamic id ;
  late bool adult ;
  late String backdrop_path;
  late String original_title;
  late String poster_path ;
  dynamic vote_average ;
  dynamic vote_count ;
  late String release_date ;
  Data.fromjson(Map<String,dynamic>json){
    id = json['id'];
    adult = json['adult'];
    backdrop_path = 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}';
    original_title = json['original_title'];
    poster_path = 'https://image.tmdb.org/t/p/w500${json['poster_path']}';
    vote_average = json['vote_average'];
    vote_count = json['vote_count'];
    release_date = json['release_date'];
  }

}