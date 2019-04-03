import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPlayers extends StatefulWidget {
  @override
  _SelectPlayersState createState() => _SelectPlayersState();
}

class _SelectPlayersState extends State<SelectPlayers> {
  List<String> _players = new List();
  int _count = 0;

  _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _players = (prefs.getStringList('playerNames') ?? List<String>());
    print('Your list  $_players');
    await prefs.setStringList('playerNames', _players);
  }

  _addPlayer() {
    setState(() {
      _count++;
      _players.add('Test$_count');
      _save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Players'),
      ),
      body: _createPlayersList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () => _addPlayer(),
      ),
    );
  }

  Widget _createPlayersList() {
    return StreamBuilder<SharedPreferences>(
        stream: SharedPreferences.getInstance().asStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            _players = snapshot.data.getStringList('playerNames');

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              itemCount: _players.length,
              itemBuilder: (context, i) {
                return new ListTile(
                  title: new Text(_players[i]),
                );
              },
            );
          } else {
            return new Container();
          }
        });
  }
}
