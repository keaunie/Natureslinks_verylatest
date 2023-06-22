import 'package:flutter/material.dart';
import 'package:natureslink/profile.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'globals.dart' as globals;

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  // late YoutubePlayerController controller;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(globals.watchVid.toString())
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void deactivate() {
    // controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget buildHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text(
                  'Natureslink',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage("""
assets/images/logo.png"""), fit: BoxFit.cover),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDescription() => Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      globals.titleVid!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Text(globals.descVid!),
                                        ],
                                      ),
                                    )),
                              ],
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          decoration:
          const BoxDecoration(image: DecorationImage(image: AssetImage("""
assets/images/bg.png"""), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildHeader(context),
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),

                // YoutubePlayer(
                //   controller: controller,
                //   showVideoProgressIndicator: true,
                //   onReady: () {
                //     print('Player is ready.');
                //   },
                // ),

                buildDescription(),
              ],
            ),
          )),
    );
  }
}
