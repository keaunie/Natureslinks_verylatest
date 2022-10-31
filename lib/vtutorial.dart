import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natureslink/home.dart';
import 'package:natureslink/splash.dart';
import 'package:video_player/video_player.dart';

class Vtutorial extends StatefulWidget {
  const Vtutorial({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Vtutorial> {
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;

  
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network('https://cdn.discordapp.com/attachments/915851925793153062/1036510096383037561/asthma.mp4');
    _videoPlayerController!.initialize().then( (_) => {
      _chewieController = ChewieController(videoPlayerController: _videoPlayerController!)
      
    });
    super.initState();
  }

  @override
  void dispose(){
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  Widget _chewieVideoPlayer() {
  return Container(
    child: Chewie(controller: _chewieController!),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ]),
            image: DecorationImage(
                image: AssetImage("assets/images/natureslinklogo.png"),
                fit: BoxFit.contain)),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Natureslink',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 20),
            // buildVideo(),
            // SizedBox(height: 15),
            // buildDesc(),
            // SizedBox(height: 15),
          ],
        ),
      ),
    );
  }


//
// Widget buildDesc() {
//   return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.green.withOpacity(0.5),
//       ),
//       alignment: Alignment.centerLeft,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 25,
//         vertical: 20,
//       ),
//       child: Column(
//         children: [
//           Column(
//             children: [
//               const Text(
//                 ' Video Tutorial',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold),
//               ),
//               const Text(
//                 'Description here',
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ],
//           ),
//         ],
//       ));
// }

}
