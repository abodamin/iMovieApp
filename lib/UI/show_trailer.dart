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
  ChewieController _chewieController;
  YoutubePlayerController _controller;

  @override
  void initState() {
    _setOrientation(Orientations.Horizontal);

    _controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        autoPlay: true,
      ),
    );
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
          backgroundColor: Colors.grey,
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

                  return FutureBuilder(
                    future: _prepareVideoPlayer(officialMovieKey),
                    builder: (context, snapshot) {
                      return YoutubePlayerIFrame(
                        controller: _controller = YoutubePlayerController(
                          initialVideoId: officialMovieKey,
                          params: YoutubePlayerParams(
                            showControls: true,
                            showFullscreenButton: false,
                            autoPlay: true,
                            privacyEnhanced: true,
                          ),
                        ),
                      );
                    },
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

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> _prepareVideoPlayer(String key) async {
    final _videoPlayerController =
        VideoPlayerController.network('https://www.youtube.com/watch?v=$key');
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
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
      default: await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }
}

enum Orientations { Horizontal, Vertical }
