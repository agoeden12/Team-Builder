import 'package:flutter/material.dart';
import 'display_team.dart';

class TeamsScreen extends StatefulWidget {
  final List<String> totalPlayers;
  final int numberOfTeams;

  TeamsScreen({
    this.totalPlayers,
    this.numberOfTeams,
  })  : assert(totalPlayers != null),
        assert(numberOfTeams != null);

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<String> totalPlayers;
  double _height, _width;
  int _numberOfTeams;

  @override
  void initState() {
    super.initState();
    totalPlayers = widget.totalPlayers;
    _numberOfTeams = widget.numberOfTeams;
    _shuffleTeams();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
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
    return Stack(
      children: <Widget>[
        createTeamDisplays(),
        _shuffleButton(),
      ],
    );
  }

  Widget createTeamDisplays() {
    switch (_numberOfTeams) {
      case 2:
        int listSections = totalPlayers.length ~/ 2;
        List teamOne = totalPlayers.sublist(0, listSections);
        List teamTwo = totalPlayers.sublist(listSections, totalPlayers.length);
        return Stack(children: <Widget>[
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
        ]);
        break;

      case 3:
        int listSections = totalPlayers.length ~/ 3;
        List teamOne = totalPlayers.sublist(0, listSections);
        List teamTwo = totalPlayers.sublist(listSections, listSections * 2);
        List teamThree =
            totalPlayers.sublist(listSections * 2, totalPlayers.length);
        return Stack(children: <Widget>[
          new DisplayTeam(
            'Red Team',
            teamNames: teamOne,
            teamColorPrimary: Colors.red[100],
            teamColorSecondary: Colors.red[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.topLeft,
          ),
          new DisplayTeam(
            'Blue Team',
            teamNames: teamTwo,
            teamColorPrimary: Colors.blue[100],
            teamColorSecondary: Colors.blue[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.topRight,
          ),
          new DisplayTeam(
            'Green Team',
            teamNames: teamThree,
            teamColorPrimary: Colors.green[100],
            teamColorSecondary: Colors.green[800],
            height: _height / 2,
            width: _width,
            pageAlignment: Alignment.bottomCenter,
          ),
        ]);
        break;

      case 4:
        int listSections = totalPlayers.length ~/ 4;
        List teamOne = totalPlayers.sublist(0, listSections);
        List teamTwo = totalPlayers.sublist(listSections, listSections * 2);
        List teamThree =
            totalPlayers.sublist(listSections * 2, listSections * 3);
        List teamFour =
            totalPlayers.sublist(listSections * 3, totalPlayers.length);
        return Stack(children: <Widget>[
          new DisplayTeam(
            'Red Team',
            teamNames: teamOne,
            teamColorPrimary: Colors.red[100],
            teamColorSecondary: Colors.red[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.topLeft,
          ),
          new DisplayTeam(
            'Blue Team',
            teamNames: teamTwo,
            teamColorPrimary: Colors.blue[100],
            teamColorSecondary: Colors.blue[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.topRight,
          ),
          new DisplayTeam(
            'Green Team',
            teamNames: teamThree,
            teamColorPrimary: Colors.green[100],
            teamColorSecondary: Colors.green[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.bottomLeft,
          ),
          new DisplayTeam(
            'Purple Team',
            teamNames: teamFour,
            teamColorPrimary: Colors.purple[100],
            teamColorSecondary: Colors.purple[800],
            height: _height / 2,
            width: _width / 2,
            pageAlignment: Alignment.bottomRight,
          ),
        ]);
        break;

      default:
        return Container();
    }
  }

  _shuffleTeams() {
    setState(() {
      totalPlayers.shuffle();
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
