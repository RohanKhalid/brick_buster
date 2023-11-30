import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameWin extends StatelessWidget {
  final bool hasPlayerWon;
  final function;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
        color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 20),
  );

  const GameWin({required this.hasPlayerWon, this.function});

  @override
  Widget build(BuildContext context) {
    return hasPlayerWon
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  'YOU WON',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.deepPurple,
                      child: const Text(
                        'Play Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}
