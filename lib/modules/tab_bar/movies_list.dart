import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/now_playing_model.dart';
import 'package:movies_app/modules/trending_movies/movie_details_screen.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

class MoviesList extends StatefulWidget {
 final  int id;
   MoviesList.byGenre({this.id});

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  bool firstRun;
  @override
  void initState() {
    super.initState();
    firstRun = true;

    AppCubit.get(context).getMovieByGenre(id: widget.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*setState(() {
      AppCubit.get(context).getMovieByGenre(id: widget.id);
    });*/

    if(firstRun){
      AppCubit.get(context).getMovieByGenre(id: widget.id);
    }
    setState(() {
      firstRun = false;
    });
  }


  @override
  Widget build(BuildContext context) {
      return  BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return(firstRun)? Center(child: CircularProgressIndicator(),): Container(
            width: double.infinity,
            child:ConditionalBuilder(
              condition: AppCubit.get(context).genre != null ,
              builder: (context) => ListView.builder(
                shrinkWrap: true,
                itemExtent: 120,
                itemCount: AppCubit.get(context).genre.results.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => listItem(AppCubit.get(context).genre.results[index],AppCubit.get(context).movieDetailModel) ,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      );

  }

  Widget listItem(ResultData data,MovieDetailModel movieDetailModel) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 5,
          child: InkWell(
            child: Image.network(
              '${data.posterPath}',
              fit: BoxFit.contain,
            ),
            onTap: (){
             setState(() {
               AppCubit.get(context).getMovieDetail(data.id);
             });
              navigateTo(context, MovieDetailsScreen(title: data.title,data: data,movieDetailModel: movieDetailModel,));
            },
          ),
        ),
        Expanded(
          child: Text(
            '${data.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${data.voteAverage }',style: TextStyle(color: Colors.white,fontSize:17,),),
                RatingBar(
                  onRatingUpdate: null,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  initialRating:double.parse('${data.voteAverage /2}'),
                  itemSize: 14,
                  unratedColor: Colors.grey,
                  glowColor: Colors.yellow,
                  minRating: 1,
                  maxRating: 5,
                  ratingWidget:RatingWidget(
                    empty: Icon(Icons.star,color: Colors.teal,),
                    full:Icon(Icons.star,color: Colors.yellow,),
                    half: Icon(Icons.star,color: Colors.yellow,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
