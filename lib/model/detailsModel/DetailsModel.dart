class DetailsModel{
  late bool adult ;
  late String backdrop_path;
  dynamic budget ;
  dynamic id ;
  List<Genres>genres=[];
  late String homepage ;
  late String overview ;
  dynamic popularity ;
  late String poster_path ;
  late String release_date ;
  late String tagline ;
  late String title;
  dynamic vote_average ;
  dynamic vote_count ;
  List<ProductCompanies>production_companies=[] ;
  List<ProductCountries>production_countries=[];

  DetailsModel.fromjson(Map<String,dynamic>json)
  {
    adult=json['adult'];
    backdrop_path = 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}';
    budget=json['budget'];
    id=json['id'];
    json['genres'].forEach((element){
      genres.add(Genres.fromjson(element));
    });
    json['production_companies'].forEach((element){
      production_companies.add(ProductCompanies.fromjson(element));
    });
    json['production_countries'].forEach((element){
      production_countries.add(ProductCountries.fromjson(element));
    });
    homepage=json['homepage'];
    overview=json['overview'];
    popularity=json['popularity'];
    poster_path='https://image.tmdb.org/t/p/w500${json['poster_path']}';
    release_date=json['release_date'];
    tagline=json['tagline'];
    title=json['title'];
    vote_average=json['vote_average'];
    vote_count=json['vote_count'];

  }
}

class Genres{
  dynamic id ;
  late String name ;
  Genres.fromjson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
  }
}

class ProductCompanies {
  dynamic id ;
  late String logo_path ;
  late String name ;
  late String origin_country ;
  ProductCompanies.fromjson(Map<String,dynamic>json)
  {
    id = json['id'] ;
    logo_path = 'https://image.tmdb.org/t/p/w500${json['logo_path']}' ;
    name = json['name'] ;
    origin_country = json['origin_country'] ;
  }
}

class ProductCountries {
  late String iso_3166_1;
  late String name;

  ProductCountries.fromjson(Map<String, dynamic>json)
  {

    name = json['name'];
    iso_3166_1 = json['iso_3166_1'];
  }
}

