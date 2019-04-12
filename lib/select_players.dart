import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'teams_screen.dart';

class SelectPlayers extends StatefulWidget {
  final int numberOfTeams;

  SelectPlayers({
    @required this.numberOfTeams,
  })  : assert(numberOfTeams != null);

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
      appBar: _appBar(),
      body: new Stack(
        children: <Widget>[
          _createPlayersList(),
          _createTeamsButton(),
        ],
      ),
    );
  }

  // App Bar for the screen to control navigation
  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Theme.of(context).platform == TargetPlatform.android
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
      title: Text(
        'Select Players',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person_add),
          color: Theme.of(context).primaryColor,
          onPressed: () => _createPlayerPop(),
        )
      ],
    );
  }

// Creating initial list of players ---------------------------------------------------------------------------------------------

  // Wait for the shared preferences to retrieve data and then build out the listview of names
  Widget _createPlayersList() {
    return StreamBuilder<SharedPreferences>(
        stream: SharedPreferences.getInstance().asStream(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            _players = snapshot.data.getStringList('playerNames');
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                    _players[i],
                    _savedPlayers.contains(_players[i]),
                  ),
                );
              },
            );
          } else {
            return new Container();
          }
        });
  }

  // Take in the player name in the list add it to the listview, if name is in the saved list then put a trailing check icon
  Widget _addPlayerToList(String playerName, bool isSaved) {
    return new ListTile(
        title: new Text(playerName),
        trailing: isSaved
            ? new Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )
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

// Go to teams screen ------------------------------------------------------------------------------------------------

  // Navigation to the teams screen passing through the saved list
  _goToTeamsScreen() {
    int numberOfTeams = widget.numberOfTeams;
    if (_savedPlayers.length >= numberOfTeams){
    setState(() {
      Route route = MaterialPageRoute(
          builder: (context) => TeamsScreen(
                totalPlayers: _savedPlayers,
                numberOfTeams: numberOfTeams,
              ));
      Navigator.push(context, route);
    });}
    else {
      Fluttertoast.showToast(
        msg: "You need to select at least $numberOfTeams players.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
      );
    }
  }

  // Raised button to go to the teams screen
  Widget _createTeamsButton() {
    return new Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: new RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: new Text('Create my teams!',
              style: TextStyle(color: Colors.white)),
          onPressed: () => _goToTeamsScreen(),
        ),
      ),
    );
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
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (!_players.contains(playerName))
                    ? () {
                        if (playerName.length != 0) {
                          _createNewPlayer(playerName);
                        }
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
