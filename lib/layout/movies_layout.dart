import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/now_playing_model.dart';
import 'package:movies_app/modules/search/search_screen.dart';
import 'package:movies_app/modules/tab_bar/tab_bar.dart';
import 'package:movies_app/modules/trailer/trailer_screen.dart';
import 'package:movies_app/modules/trending_movies/trending_movie_screen.dart';
import 'package:movies_app/modules/trending_persons/trending_persons_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';
import 'package:page_indicator/page_indicator.dart';


class MoviesLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: AppCubit.get(context).nowPlayingModel != null ,
            builder: (context) =>  Scaffold(
              appBar: AppBar(
                title: Text('Movies'),
               /* leading: IconButton(
                  icon: Icon(Icons.dehaze_rounded),
                  onPressed: () {},
                ),*/
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                     navigateTo(context, SearchScreen());
                    },
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition:AppCubit.get(context).nowPlayingModel != null || AppCubit.get(context).genre != null ,
                builder: (context) =>  SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.34,
                        width: double.infinity,
                        child: PageIndicatorContainer(
                          length: AppCubit.get(context).nowPlayingModel.results.length,
                          indicatorSelectorColor: Colors.red,
                          indicatorColor: Colors.white,
                          shape: IndicatorShape.circle(size: 5),
                          child: PageView.builder(
                            itemBuilder:(context, index) => nowPlaying(AppCubit.get(context).nowPlayingModel.results[index],context),
                            itemCount: AppCubit.get(context).nowPlayingModel.results.length,
                          ),
                        ),
                      ),
                      Genres(),
                      TrendingPersonsScreen(),
                      TrendingMoviesScreen(),
                    ],
                  ),
                ),
                fallback: (context) =>  Center(child: CircularProgressIndicator()),
              ),
            ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget nowPlaying(ResultData data,context) => Stack(
    children: [
      Image.network(
          '${data.backdropPath}',
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.6),
                Theme.of(context).primaryColor.withOpacity(0.3),
              ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0,0.9],
          ),
        ),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        top: 0,
        child: IconButton(
            icon: Icon(Icons.play_circle_outline,size:60,color: Colors.yellow,),
            onPressed: (){
              AppCubit.get(context).getVideoByID(data.id).then((value) {

              navigateTo(context,TrailerScreen(videoId: AppCubit.get(context).videoModel.results[0].key,title: data.title,),);
              });
            },
        ),
      ),
      Positioned(
        bottom: 20,
        left: 5,
        child: Container(
          width: 140,
          child: Text(
            '${data.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    ],
  );
}
