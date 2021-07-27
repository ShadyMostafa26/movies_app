import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/trending_movies_model.dart';
import 'package:movies_app/modules/trending_movies/treinding_movie_details_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

class TrendingMoviesScreen extends StatefulWidget {
  @override
  _TrendingMoviesScreenState createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).trendingMovies != null,
          builder: (context) => Container(
            // height: MediaQuery.of(context).size.height * 0.48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' Trending Movies',style: Theme.of(context).textTheme.headline6,),
                SizedBox(height: 4),
                movieList(context),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget movieList(context) => Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.40,
    child:ListView.builder(
      shrinkWrap: true,
      itemExtent: 120,
      itemCount: AppCubit.get(context).trendingMovies.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => listItem(AppCubit.get(context).trendingMovies.results[index],context,AppCubit.get(context).movieDetailModel) ,
    ),
  );

  Widget listItem(TrendingMoviesResult data,context,MovieDetailModel movieDetailModel) => Padding(
    padding:  EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child: InkWell(
            child: Image.network(
              '${data.posterPath}',
              fit: BoxFit.cover,
            ),
            onTap: (){

               AppCubit.get(context).getMovieDetail(data.id).then((value) {
             navigateTo(context, TrendingMovieDetailsScreen(title: data.title, trendingMoviesResult: data, movieDetailModel: movieDetailModel,),);

               });
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${data.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),

      ],
    ),
  );
}
