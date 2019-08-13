import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:team_builder/select_players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Builder',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: MyHomePage(title: 'Team Builder'),
      debugShowCheckedModeBanner: false,
    );
  }
}

final String logoAssetName = "assets/app_logo.png";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _goToSelectPlayers(int numberOfTeams) {
    setState(() {
      Route route = MaterialPageRoute(
        builder: (context) => SelectPlayers(
              numberOfTeams: numberOfTeams,
            ),
      );
      Navigator.push(context, route);
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
            color: Theme.of(context).colorScheme.secondary,
          ),
          iconSize: 35.0,
          onPressed: () => _shareApp(),
        )
      ],
    );
  }

  _shareApp() {
    Share.share(
        'Check out this app that makes everything about creating teams much easier! https://play.google.com/store/apps/details?id=com.agoeden.teambuilder',
        sharePositionOrigin: Rect.fromLTWH(50, 50, 100, 100));
  }

  Widget _showBody() {
    return Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Align(
          alignment: Alignment(0, -0.75),
          child: Image(
            image: AssetImage(
              logoAssetName,
            ),
            height: 300,
            width: 300,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Align(
          alignment: Alignment(0, 0.2),
          child: Text(
            'Select The Number Of Teams:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondaryVariant,
              fontSize: 24,
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, 0.45),
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
        color: Theme.of(context).colorScheme.secondary,
        textColor: Colors.white,
        splashColor: Theme.of(context).colorScheme.secondaryVariant,
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
