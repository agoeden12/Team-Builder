import 'package:flutter/material.dart';
import 'package:team_builder/select_players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Builder',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
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

  _goToSelectPlayers(){
    setState(() {
      Route route = MaterialPageRoute(builder: (context) => SelectPlayers());
      Navigator.push(context, route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Choose Players'),
          onPressed: () => _goToSelectPlayers(),
        ),
      ),
    );
  }
}
