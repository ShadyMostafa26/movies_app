abstract class AppStates{}

class AppInitialState extends AppStates{}

class GetNowPlayingDataLoadingState extends AppStates{}
class GetNowPlayingDataSuccessState extends AppStates{}
class GetNowPlayingDataErrorState extends AppStates{}

class GetGenresLoadingState extends AppStates{}
class GetGenresSuccessState extends AppStates{}
class GetGenresErrorState extends AppStates{}

class GetMovieByGenreLoadingState extends AppStates{}
class GetMovieByGenreSuccessState extends AppStates{}
class GetMovieByGenreErrorState extends AppStates{}

class GetPersonLoadingState extends AppStates{}
class GetPersonSuccessState extends AppStates{}
class GetPersonErrorState extends AppStates{}


class GetTrendingMoviesLoadingState extends AppStates{}
class GetTrendingMoviesSuccessState extends AppStates{}
class GetTrendingMoviesErrorState extends AppStates{}


class GetTMovieDetailLoadingState extends AppStates{}
class GetTMovieDetailSuccessState extends AppStates{}
class GetTMovieDetailErrorState extends AppStates{}


class SearchLoadingState extends AppStates{}
class SearchSuccessState extends AppStates{}
class SearchErrorState extends AppStates{}

class GetVideoLoadingState extends AppStates{}
class GetVideoSuccessState extends AppStates{}
class GetVideoErrorState extends AppStates{}