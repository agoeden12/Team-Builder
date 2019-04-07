import 'package:flutter/material.dart';

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
  List<String> teamOne, teamTwo;

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
        _buildTeam(totalPlayers, _height, _width / 2, Colors.red[100],
            Alignment.topLeft, true),
        _buildTeam(totalPlayers, _height, _width / 2, Colors.blue[100],
            Alignment.topRight, false),
        _shuffleButton(),
      ],
    );
  }

  Widget _buildTeam(List<String> teamNames, double _height, double _width,
      Color teamColor, Alignment pageAlignment, bool isRed) {
    return Align(
      alignment: pageAlignment,
      child: Container(
        color: teamColor,
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                isRed ? 'Red Team' : 'Blue Team',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isRed ? Colors.red[800] : Colors.blue[800],
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: teamNames.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(18, 4, 12, 4),
                    child: Text(
                      teamNames[i],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _shuffleTeams() {
    totalPlayers.shuffle();
    for (int index; index < totalPlayers.length/2; index++){
      
    }
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
          onPressed: () => _shuffleTeams,
        ),
      ),
    );
  }
}
