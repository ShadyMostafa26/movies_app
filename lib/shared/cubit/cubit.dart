import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/geners_model.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/now_playing_model.dart';
import 'package:movies_app/models/person_model.dart';
import 'package:movies_app/models/search_model.dart';
import 'package:movies_app/models/trending_movies_model.dart';
import 'package:movies_app/models/video_model.dart';
import 'package:movies_app/shared/cubit/states.dart';
import 'package:movies_app/shared/helpers/constants.dart';
import 'package:movies_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  NowPlayingModel nowPlayingModel;
  void getNowPlaying() {
    emit(GetNowPlayingDataLoadingState());
    DioHelPer.getData(
      path: 'movie/now_playing',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      nowPlayingModel = NowPlayingModel.fromJson(value.data);
      emit(GetNowPlayingDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNowPlayingDataErrorState());
    });
  }

  GenresModel genresModel;
  void getGenres() {
    emit(GetGenresLoadingState());
    DioHelPer.getData(
      path: 'genre/movie/list',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      genresModel = GenresModel.fromJson(value.data);
      emit(GetGenresSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetGenresErrorState());
    });
  }


  NowPlayingModel genre;
  Future<Response> getMovieByGenre({int id}) async{
    emit(GetMovieByGenreLoadingState());
   return DioHelPer.getData(
      path: 'discover/movie',
      query: {
        'api_key': Constants.apiKey,
        'with_genres': id,
      },
    ).then((value) {
      genre = NowPlayingModel.fromJson(value.data);
      emit(GetMovieByGenreSuccessState());
    }).catchError((error) {
      emit(GetMovieByGenreErrorState());
    });
  }


  PersonModel personModel;
  void getPersons() {
    emit(GetPersonLoadingState());
    DioHelPer.getData(
      path: 'trending/person/week',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      personModel = PersonModel.fromJson(value.data);
      emit(GetPersonSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPersonErrorState());
    });
  }


  TrendingMovies trendingMovies;
  void getTrendingMovies() {
    emit(GetTrendingMoviesLoadingState());
    DioHelPer.getData(
      path: 'trending/movie/week',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      trendingMovies = TrendingMovies.fromJson(value.data);
      emit(GetTrendingMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendingMoviesErrorState());
    });
  }


  MovieDetailModel movieDetailModel;
  Future<Response> getMovieDetail(int id) async{
    emit(GetTMovieDetailLoadingState());
   return await DioHelPer.getData(
      path: 'movie/$id',
      query: {
        'api_key': Constants.apiKey,
      },
    ).then((value) {
      movieDetailModel = MovieDetailModel.fromJson(value.data);
      emit(GetTMovieDetailSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTMovieDetailErrorState());
    });
  }


  SearchModel searchModel;
  void searchMovie(String q) {
    emit(SearchLoadingState());
    DioHelPer.getData(
      path: 'search/movie',
      query: {
        'api_key': Constants.apiKey,
        'query': q,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }


  VideoModel videoModel;
  Future<Response> getVideoByID(int id)async{
   emit(GetVideoLoadingState());
   return await DioHelPer.getData(
       path: 'movie/$id/videos',
       query: {
         'api_key': Constants.apiKey,
       },
   ).then((value) {
     videoModel = VideoModel.fromJson(value.data);
     emit(GetVideoSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(GetVideoErrorState());
   });
  }
}
