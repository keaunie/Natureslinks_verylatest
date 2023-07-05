import 'package:flutter/material.dart';
import 'package:natureslink/profile.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'globals.dart' as globals;

void main() => runApp(const productInfo());

/// Stateful widget to fetch and then display video content.
class productInfo extends StatefulWidget {
  const productInfo({Key? key}) : super(key: key);

  @override
  _productInfoState createState() => _productInfoState();
}

class _productInfoState extends State<productInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    // controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
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
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Image.network(globals.productLink),
          SizedBox(
            height: 10,
          ),
          Text(
            globals.productName,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text('Stocks Left: '+globals.productStock),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(globals.productDetails),
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
