import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/search_model.dart';
import 'package:movies_app/modules/search/movie_details_screen_search.dart';
import 'package:movies_app/shared/components/components.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Search'),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style:TextStyle(
                        color: Colors.black,
                      ) ,
                      controller: searchController,
                      onFieldSubmitted: (value) {
                             AppCubit.get(context).searchMovie(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'search a movie,actor ....',
                        hintStyle: TextStyle(color: Colors.black),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                      ),
                    ),
                    if(state is SearchLoadingState)
                     SizedBox(height: 15,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(backgroundColor: Colors.blue,),
                      SizedBox(height: 20,),
                   ConditionalBuilder(
                     condition: AppCubit.get(context).searchModel != null,
                     builder: (context) =>  ListView.separated(
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (context, index) => searchItem(AppCubit.get(context).searchModel.results[index],context),
                       separatorBuilder: (context, index) => Divider(height: 1,),
                       itemCount: AppCubit.get(context).searchModel.results.length,
                     ),
                     fallback: (context) => Container(),
                   ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget searchItem(SearchResult model,context) =>  InkWell(
    onTap: () {
          navigateTo(context, SearchDetail(model: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 140,
                child: Image.network(
                  '${model.posterPath}',
                  fit: BoxFit.fill,
                ),),
              SizedBox(width: 8,),
              Expanded(child: Text('${model.originalTitle}'))
            ],
          )
        ],
      ),
    ),
  );
}
