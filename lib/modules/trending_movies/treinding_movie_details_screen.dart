import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/now_playing_model.dart';
import 'package:movies_app/models/trending_movies_model.dart';
import 'package:movies_app/modules/trailer/trailer_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';
import 'package:sliver_fab/sliver_fab.dart';

class TrendingMovieDetailsScreen extends StatelessWidget {

 final TrendingMoviesResult trendingMoviesResult;
  final String title;
  final MovieDetailModel movieDetailModel;

  TrendingMovieDetailsScreen({this.title,this.movieDetailModel,this.trendingMoviesResult});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {

          AppCubit.get(context).getMovieDetail(trendingMoviesResult.id);
         AppCubit.get(context).getVideoByID(trendingMoviesResult.id);

          return  BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: AppCubit.get(context).movieDetailModel != null,
                builder: (context) =>  Scaffold(
                  body: SliverFab(
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    floatingWidget: FloatingActionButton(
                      onPressed: () {
                        navigateTo(context,TrailerScreen(videoId: AppCubit.get(context).videoModel.results[0].key,title: trendingMoviesResult.title,));
                      },
                      child: Icon(Icons.play_arrow),
                    ),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: MediaQuery.of(context).size.height * 0.4,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              trendingMoviesResult.title,
                              style: TextStyle(fontSize: 15),
                              maxLines: 2,
                            ),
                          ),
                          background: Stack(
                            children: [
                              Container(
                                height: double.infinity,
                                child: Image.network(
                                  trendingMoviesResult.backDrop,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor.withOpacity(.3),
                                      Theme.of(context).primaryColor.withOpacity(.6),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(10),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Row(
                                children: [
                                  Text(
                                    'Rate: ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '${trendingMoviesResult.voteAverage}',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              Text('Overview',style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 20),),
                              Text(
                                '${trendingMoviesResult.originalTitle}: ', style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('BUDGET',style: Theme.of(context).textTheme.headline6,),
                                      Text('${AppCubit.get(context).movieDetailModel.budget} \$',style: TextStyle(color: Theme.of(context).accentColor),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('DURATION',style: Theme.of(context).textTheme.headline6,),
                                      Text('${AppCubit.get(context).movieDetailModel.runtime} min',style: TextStyle(color: Theme.of(context).accentColor),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text('RELEASE DATE',style: Theme.of(context).textTheme.headline6,),
                                      Text('${AppCubit.get(context).movieDetailModel.releaseDate}',style: TextStyle(color: Theme.of(context).accentColor),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),

                              Text('Genres',style: Theme.of(context).textTheme.headline6,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                  itemBuilder:(context, index) =>  buildGenreItem(AppCubit.get(context).movieDetailModel.genres[index],context),
                                  separatorBuilder: (context, index) => SizedBox(width: 5,),
                                  itemCount: AppCubit.get(context).movieDetailModel.genres.length,
                              ),
                            ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              );
            },
          );
        },
    );
  }

  Widget buildGenreItem(GenreList model,context) =>  Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(
            top: BorderSide(color: Colors.white,),
            bottom: BorderSide(color: Colors.white),
            left: BorderSide(color: Colors.white),
            right: BorderSide(color: Colors.white),

          ),
          borderRadius: BorderRadius.all(Radius.circular(5),),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '${model.name}',style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
