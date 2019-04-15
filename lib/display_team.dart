import 'package:flutter/material.dart';

class DisplayTeam extends StatelessWidget {

  final double height, width;
  final String teamName;
  final List<String> teamNames;
  final Color teamColorPrimary, teamColorSecondary;
  final Alignment pageAlignment;

  DisplayTeam(this.teamName, {
    @required this.height,
    @required this.width,
    @required this.teamColorPrimary,
    @required this.teamColorSecondary,
    @required this.teamNames,
    @required this.pageAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: pageAlignment,
      child: Container(
        color: teamColorPrimary,
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                teamName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: teamColorSecondary,
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

}