import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_movie_app/App/Globals.dart';
import 'package:i_movie_app/App/api.dart';
import 'package:i_movie_app/App/imports.dart';
import 'package:i_movie_app/Model/movie_videos.dart';
import 'package:i_movie_app/UI/Widgets/MyLoadingWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ShowTrailerPage extends StatefulWidget {
  final movieId;

  const ShowTrailerPage({
    @required this.movieId,
  });

  @override
  _ShowTrailerPageState createState() => _ShowTrailerPageState();
}

class _ShowTrailerPageState extends State<ShowTrailerPage> {

  @override
  void initState() {
    _setOrientation(Orientations.Horizontal);
    mLogger.i("movieID: ${widget.movieId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _setOrientation(Orientations.Vertical);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: getMediaHeight(context),
            width: getMediaWidth(context),
            child: FutureBuilder<MovieVideos>(
              future: ApiClient.apiClient.getMovieVideos(widget.movieId),
              builder: (context, mvsnapshpt) {
                if (mvsnapshpt.hasData) {
                  String officialMovieKey = mvsnapshpt?.data?.results
                      ?.where((element) => element.official == true)
                      ?.first
                      ?.key;

                  return YoutubePlayerIFrame(
                    controller: YoutubePlayerController(
                      initialVideoId: officialMovieKey,
                      params: YoutubePlayerParams(
                        showControls: true,
                        showFullscreenButton: false,
                        autoPlay: true,
                        privacyEnhanced: true,
                      ),
                    ),
                  );
                } else if (mvsnapshpt.hasError) {
                  return Center(
                    child: Text(
                      "Ops something went wrong, maybe this movie has no trailer :/ ",
                      style: getTextTheme(context).headline6,
                    ),
                  );
                } else {
                  return MyLoadingWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _setOrientation(Orientations orientation) async {
    switch (orientation) {
      case Orientations.Horizontal:
        return await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      case Orientations.Vertical:
        return await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      default:
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
    }
  }
}

enum Orientations { Horizontal, Vertical }
