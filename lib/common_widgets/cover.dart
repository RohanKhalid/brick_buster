import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cover extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;
  final bool hasPlayerWon;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
        color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 20),
  );

  Cover(
      {required this.hasGameStarted,
      required this.isGameOver,
      required this.hasPlayerWon});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.5),
            child: Text(
              isGameOver || hasPlayerWon ? '' : 'BRICK BRAKER',
              style: gameFont.copyWith(color: Colors.deepPurple[200]),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.5),
                child: Text(
                  'BRICK BRAKER',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.1),
                child: Text(
                  'tap to play',
                  style: TextStyle(color: Colors.deepPurple[400]),
                ),
              ),
            ],
          );
  }
}
