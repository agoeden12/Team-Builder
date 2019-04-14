import 'package:flutter/material.dart';
import 'package:team_builder/select_players.dart';
import 'package:share/share.dart';
// import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Builder',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: MyHomePage(title: 'Team Builder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // FirebaseAdMob adMob = FirebaseAdMob.instance.initialize(appId: ca-app-pub-3307735555687835~1516596922);

  // MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  // keywords: <String>['flutterio', 'beautiful apps'],
  // contentUrl: 'https://flutter.io',
  // birthday: DateTime.now(),
  // childDirected: false,
  // designedForFamilies: false,
  // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  // testDevices: <String>[], // Android emulators are considered test devices
  // );

  // BannerAd myBanner = BannerAd(
  // // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // // https://developers.google.com/admob/android/test-ads
  // // https://developers.google.com/admob/ios/test-ads
  // adUnitId: ca-app-pub-3307735555687835/2254963528,
  // size: AdSize.smartBanner,
  // targetingInfo: targetingInfo,
  // listener: (MobileAdEvent event) {
  //   print("BannerAd event is $event");
  // },
  // );

  _goToSelectPlayers(int numberOfTeams) {
    setState(() {
      Route route = MaterialPageRoute(
          builder: (context) => SelectPlayers(
                numberOfTeams: numberOfTeams,
              ));
      Navigator.push(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar(),
      body: _showBody(),
    );
  }

  Widget _showAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 30.0,
          onPressed: () => _shareApp(),
        )
      ],
    );
  }

  _shareApp() {
    Share.share('text', sharePositionOrigin: Rect.fromLTWH(50, 50, 100, 100));
  }

  Widget _showBody() {
    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Align(
          alignment: Alignment(0, -0.5),
          child: Text(widget.title),
        ),
        Align(
          alignment: Alignment(0, 0.25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _createButton(2),
              _createButton(3),
              _createButton(4),
            ],
          ),
        ),
  //       myBanner
  // // typically this happens well before the ad is shown
  // ..load()
  // ..show(
  //   // Positions the banner ad 60 pixels from the bottom of the screen
  //   anchorOffset: 60.0,
  //   // Banner Position
  //   anchorType: AnchorType.bottom,
  // );
      ],
    );
  }

  Widget _createButton(int teamAmount) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(12.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        splashColor: Theme.of(context).primaryColorLight,
        onPressed: () => _goToSelectPlayers(teamAmount),
        child: Text(
          '$teamAmount',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
