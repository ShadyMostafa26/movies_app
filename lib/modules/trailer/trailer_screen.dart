import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/shared/cubit/cubit.dart';
import 'package:movies_app/shared/cubit/states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatelessWidget {
  final String videoId;
  final String title;

  TrailerScreen({this.videoId,this.title});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text('$title'),
            centerTitle: false,
          ),
          body: Stack(
            children: [
              Center(
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                      initialVideoId: videoId
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
