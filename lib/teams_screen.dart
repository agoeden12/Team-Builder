import 'package:flutter/material.dart';
import 'display_team.dart';

class TeamsScreen extends StatefulWidget {
  final List<String> totalPlayers;

  TeamsScreen({
    this.totalPlayers,
  }) : assert(totalPlayers != null);

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<String> totalPlayers;
  List<String> teamOne = new List<String>();
  List<String> teamTwo = new List<String>();

  @override
  void initState() {
    super.initState();
    totalPlayers = widget.totalPlayers;
    _shuffleTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _showTeams(),
    );
  }

  // When the close button is pressed, go back to the home screen
  _popUntilHomeScreen() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  // App Bar for the screen to control navigation
  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () => _popUntilHomeScreen(),
      ),
      title: Text(
        'Your Teams',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.people),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }

// Body of the screen, shows separated teams and has a shuffle button ------------------------------------------------

  // Main body widget which is called by the scaffold
  Widget _showTeams() {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        new DisplayTeam(
          'Red Team',
          teamNames: teamOne,
          teamColorPrimary: Colors.red[100],
          teamColorSecondary: Colors.red[800],
          height: _height,
          width: _width / 2,
          pageAlignment: Alignment.topLeft,
        ),
        new DisplayTeam(
          'Blue Team',
          teamNames: teamTwo,
          teamColorPrimary: Colors.blue[100],
          teamColorSecondary: Colors.blue[800],
          height: _height,
          width: _width / 2,
          pageAlignment: Alignment.topRight,
        ),
        _shuffleButton(),
      ],
    );
  }

  _shuffleTeams() {
    setState(() {
      totalPlayers.shuffle();
      teamOne.removeRange(0, teamOne.length);
      teamTwo.removeRange(0, teamTwo.length);
      for (int index = 0; index < totalPlayers.length ~/ 2; index++) {
        teamOne.add(totalPlayers[index]);
      }
      for (int index = totalPlayers.length ~/ 2; index < totalPlayers.length; index++) {
        teamTwo.add(totalPlayers[index]);
      }
    });
  }

  Widget _shuffleButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: RaisedButton(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Shuffle Teams',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () => _shuffleTeams(),
        ),
      ),
    );
  }
}
