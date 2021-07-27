import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_app/models/now_playing_model.dart';
import 'package:movies_app/modules/tab_bar/movies_list.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> with TickerProviderStateMixin {
 TabController tabController;

 @override
  void initState(){
    super.initState();
    tabController = TabController(length: AppCubit.get(context).genresModel.genres.length, vsync: this);
  }
@override
  void dispose() {
   tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
    listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:AppCubit.get(context).genresModel != null || AppCubit.get(context).genre != null,
          builder: (context) =>  Container(
            height: MediaQuery.of(context).size.height * 0.5 - 50,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,
                bottom: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  tabs: AppCubit.get(context).genresModel.genres.map((e) => Text(e.name)).toList(),
                ),
              ),
              body: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: AppCubit.get(context).genresModel.genres.map((e) => MoviesList.byGenre(id: e.id,)).toList(),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

 /* Widget movieList() => Container(
    width: double.infinity,
    child:ListView.builder(
      shrinkWrap: true,
      itemExtent: 120,
      itemCount: AppCubit.get(context).nowPlayingModel.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => listItem(AppCubit.get(context).nowPlayingModel.results[index]) ,
    ),
  );

 Widget listItem(ResultData data) => Padding(
   padding: EdgeInsets.symmetric(horizontal: 5),
   child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
     mainAxisSize: MainAxisSize.min,
     children: [
         Expanded(
           flex: 5,
           child: Image.network(
             '${data.posterPath}',
             fit: BoxFit.contain,
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
                 Text('${data.voteAverage /2}',style: TextStyle(color: Colors.white,fontSize:17,),),
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
 );*/
}
