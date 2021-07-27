import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/layout/movies_layout.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';
import 'package:movies_app/shared/helpers/constants.dart';
import 'package:movies_app/shared/helpers/helpers.dart';
import 'package:movies_app/shared/network/remote/dio_helper.dart';

void main() {
  DioHelPer.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getNowPlaying()..getGenres()..getPersons()..getTrendingMovies(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Movies',
              theme: ThemeData(
                fontFamily: 'Poppins',
                primarySwatch:Constants.color,
                accentColor: Color.fromRGBO(245, 195, 15, 1),
                scaffoldBackgroundColor: Constants.color,
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              home: MoviesLayout(),
            );
          },
      ),
    );
  }
}
