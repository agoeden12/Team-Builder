import 'package:flutter/material.dart';
import 'package:team_builder/select_players.dart';
import 'package:share/share.dart';

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
        )
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
