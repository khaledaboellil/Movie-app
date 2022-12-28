import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/moviestates.dart';
import 'package:movie_app/model/popular%20model/popularmodel.dart';
import 'package:movie_app/module/HomeScreen/homescreen.dart';
import 'package:movie_app/module/Moviedetails/DetailsScreen.dart';
import 'package:movie_app/module/SearchScreen/searchscreen.dart';
import 'package:movie_app/shared/companents/companents.dart';
import 'package:movie_app/shared/network/endpoint/endpoint.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';

import '../../model/ActorModel/ActorModel.dart';
import '../../model/CastModel/CastModel.dart';
import '../../model/detailsModel/DetailsModel.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() :super(InitialLayoutState());


  static LayoutCubit get(context)=>BlocProvider.of(context);
  List<Widget>screens=[HomeScreen(),SearchScreen()];
  int current_Index=0 ;
  void changeNavBar(index){

    current_Index =index ;
    emit(ChangeNavBarState());
  }


  PopularModel ?nowPlayingModel ;
  List<Widget>Images=[] ;
  void getNowPlaying(context){
    emit(GetNowPlayingLoadingState());
    DioHelper.getData(url:NOWPLAYING).then((value){
      print('ana hna');
      nowPlayingModel=PopularModel.fromjson(value!.data);
      nowPlayingModel!.results.forEach((element) {
        Images.add(InkWell(
            onTap: (){
              navigateTo(context, DetailsScreen(element.id));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(element.poster_path,),width: double.infinity,fit: BoxFit.fill,),
                Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.6),
                    child: Text(textAlign: TextAlign.center,element.original_title,style: TextStyle(color: Colors.white,fontSize: 20),))
              ],
            )));
      });
      emit(GetNowPlayingSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetNowPlayingErrorState());
    });
  }


  PopularModel ?popularModel ;
  void getPopular(){
    emit(GetPopularLoadingState());
    DioHelper.getData(url:POPULAR).then((value){
      print('ana hna');
      popularModel=PopularModel.fromjson(value!.data);
      emit(GetPopularSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetPopularErrorState());
    });
  }



  PopularModel ?topRatedModel ;

  void getTopRated(){
    emit(GetTopRatedLoadingState());
    DioHelper.getData(url:TOPRATED).then((value){
      print('ana hna');
      topRatedModel=PopularModel.fromjson(value!.data);
      emit(GetTopRatedSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetTopRatedErrorState());
    });
  }

  PopularModel ?upComingModel ;
  void getUpComing(){
    emit(GetUpComingLoadingState());
    DioHelper.getData(url:UPCOMING).then((value){
      print('ana hna');
      upComingModel=PopularModel.fromjson(value!.data);
      emit(GetUpComingSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetUpComingErrorState());
    });
  }

 DetailsModel ?detailsModel ;

  void getDetails(id){
    emit(GetDetailsLoadingState());
    DioHelper.getData(url:'movie/${id}?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa').then((value){
      print('ana hna');
      detailsModel=DetailsModel.fromjson(value!.data);
      emit(GetDetailsSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetDetailsErrorState());
    });
  }


  CastModel ?castModel ;

  void getCast(id){
    emit(GetCastLoadingState());
    DioHelper.getData(url:'movie/${id}/credits?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa').then((value){
      print('ana hna');
     castModel=CastModel.fromJson(value!.data);
      emit(GetCastSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetCastErrorState());
    });
  }

  PopularModel ?similarModel ;
  void getSimilar(id){
    emit(GetSimilarLoadingState());
    DioHelper.getData(url:'movie/${id}/similar?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa').then((value){
      print('ana hna');
      similarModel=PopularModel.fromjson(value!.data);
      print(similarModel!.results.length);
      emit(GetSimilarSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetSimilarErrorState());
    });
  }

  ActorModel ?actorModel ;

  void getActor(id){
    emit(GetActorLoadingState());
    DioHelper.getData(url:'person/${id}?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa').then((value){
      print('ana hna');
      actorModel=ActorModel.fromJson(value!.data);
      print(similarModel!.results.length);
      emit(GetActorSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetActorErrorState());
    });
  }

  PopularModel ?actorPopularModel ;
  void getActorPopular(id){
    emit(GetActorPopularLoadingState());
    DioHelper.getData(url: 'discover/movie?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa&with_people=${id}').then((value){
      print('ana hna');
      actorPopularModel=PopularModel.fromjson(value!.data);
      emit(GetActorPopularSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetActorPopularErrorState());
    });
  }

  PopularModel ?searchModel ;
  void getSearch(String name){
    emit(GetSearchLoadingState());
    if(name.isNotEmpty)
    DioHelper.getData(url: 'search/movie?api_key=31dcc3eeba81ab1f4c71b0699bdbe6aa&query=${name}').then((value){
      print('ana hna');
      searchModel=PopularModel.fromjson(value!.data);
      print(searchModel!.results.length);
      emit(GetSearchSucessState());
    }).catchError((error){
      print('ana feh elerror');
      print(error.toString());
      emit(GetSearchErrorState());
    });
  }



}