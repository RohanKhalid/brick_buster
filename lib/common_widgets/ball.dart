import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final ballX;
  final ballY;
  final bool isGameOver;
  final bool hasGameStarted;
  final bool hasPlayerWon;

  MyBall(
      {this.ballX,
      this.ballY,
      required this.isGameOver,
      required this.hasGameStarted,
      required this.hasPlayerWon});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isGameOver || hasPlayerWon
                    ? Colors.deepPurple[300]
                    : Colors.deepPurple,
              ),
              width: 10,
              height: 10,
            ),
          )
        : Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              endRadius: 60.0,
              child: Material(
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    radius: 7.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple,
                      ),
                      width: 15,
                      height: 15,
                    )),
              ),
            ),
          );
  }
}
