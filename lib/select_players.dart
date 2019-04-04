import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class SelectPlayers extends StatefulWidget {
  @override
  _SelectPlayersState createState() => _SelectPlayersState();
}

class _SelectPlayersState extends State<SelectPlayers> {
  List<String> _players = new List();
  List<String> _savedPlayers = new List();

  // Saving the @_players list to SharedPreferences
  _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _players = (prefs.getStringList('playerNames') ?? List<String>());
    print('Your list  $_players');
    await prefs.setStringList('playerNames', _players);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Theme.of(context).platform == TargetPlatform.android
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        title: Text('Select Players'),
      ),
      body: _createPlayersList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () => _createPlayerPop(),
      ),
    );
  }

// Creating initial list of players ---------------------------------------------------------------------------------------------

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
                return new Dismissible(
                  key: new Key(_players[i]),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    if (_savedPlayers.contains(_players[i]))
                      _savedPlayers.remove(_players[i]);
                    _players.remove(_players[i]);

                    print(_players);
                    print(_savedPlayers);
                  },
                  child: _addPlayerToList(
                      _players[i], _savedPlayers.contains(_players[i])),
                );
              },
            );
          } else {
            return new Container();
          }
        });
  }

  Widget _addPlayerToList(String playerName, bool isSaved) {
    return new ListTile(
        title: new Text(playerName),
        trailing: isSaved
            ? new Icon(Icons.check)
            : new Container(
                width: 0,
              ),
        onTap: () {
          setState(() {
            isSaved
                ? _savedPlayers.remove(playerName)
                : _savedPlayers.add(playerName);
            print(_savedPlayers);
          });
        });
  }

//Create new Players -------------------------------------------------------------------------------------------------

  // Create dialog for adding a name to the list.
  _createPlayerPop() {
    String playerName = '';
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  decoration: new InputDecoration(
                      labelText: 'Player Name', hintText: 'eg. John D.'),
                  onChanged: (newName) {
                    playerName = newName;
                  },
                ),
              ),
              new IconButton(
                icon: Icon(Icons.add),
                disabledColor: Colors.black54,
                onPressed:
                    (playerName.length != 0 && !_players.contains(playerName))
                        ? () {
                            _createNewPlayer(playerName);
                            Navigator.of(context).pop();
                          }
                        : () {},
              ),
            ],
          ),
        );
      },
    );
  }

  // Takes in the text from the popup to create a new player.
  _createNewPlayer(String newPlayerName) {
    setState(() {
      _players.add(newPlayerName);
      _save();
    });
  }
}
