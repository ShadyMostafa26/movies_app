import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/person_model.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

class TrendingPersonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<AppCubit,AppStates>(
     listener: (context, state) {},
     builder: (context, state) {
       return  ConditionalBuilder(
         condition: AppCubit.get(context).personModel != null,
         builder: (context) => Container(
           height: 218,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               Text(' Trending Actors',style: Theme.of(context).textTheme.headline6,),
               SizedBox(height: 4),
               personsList(context),
             ],
           ),
         ),
         fallback: (context) => Center(child: CircularProgressIndicator()),
       );
     },
   );
  }

  Widget personsList(context) => Container(
    width: double.infinity,
    height: 180,
    child:ListView.builder(
      shrinkWrap: true,
      itemExtent: 120,
      itemCount:AppCubit.get(context).personModel.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => listItem(AppCubit.get(context).personModel.results[index]) ,
    ),
  );

  Widget listItem(PersonResults data) => Padding(
    padding:  EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
           backgroundImage: NetworkImage(
               '${data.profilePath}',
           ),
          ),
          Text(
            '${data.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
