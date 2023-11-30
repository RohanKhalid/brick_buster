import 'package:brick_buster/common_widgets/ball.dart';
import 'package:brick_buster/common_widgets/bricks.dart';
import 'package:brick_buster/common_widgets/cover.dart';
import 'package:brick_buster/common_widgets/game_over.dart';
import 'package:brick_buster/common_widgets/game_win.dart';
import 'package:brick_buster/common_widgets/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) {
        return RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              controller.moveLeft();
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              controller.moveRight();
            }
          },
          child: GestureDetector(
            onTap: controller.startGame,
            onTapDown: (details) {
              double screenWidth = MediaQuery.of(context).size.width;
              double tapPositionX = details.globalPosition.dx;

              if (tapPositionX < screenWidth / 2) {
                controller.moveLeft();
              } else {
                controller.moveRight();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.deepPurple[100],
              body: Center(
                child: Stack(
                  children: [
                    //tap to play
                    Cover(
                      hasGameStarted: controller.hasGameStarted,
                      isGameOver: controller.isGameOver,
                      hasPlayerWon: controller.hasPlayerWon,
                    ),
                    //game over screen
                    GameOver(
                      isGameOver: controller.isGameOver,
                      function: controller.resetGame,
                    ),
                    GameWin(
                      hasPlayerWon: controller.hasPlayerWon,
                      function: controller.resetGame,
                    ),
                    //ball
                    MyBall(
                      ballX: controller.ballX,
                      ballY: controller.ballY,
                      hasGameStarted: controller.hasGameStarted,
                      isGameOver: controller.isGameOver,
                      hasPlayerWon: controller.hasPlayerWon,
                    ),
                    //player
                    MyPlayer(
                      playerX: controller.playerX,
                      playerWidth: controller.playerWidth,
                    ),
                    //bricks
                    MyBrick(
                      brickX: controller.myBricks[0][0],
                      brickY: controller.myBricks[0][1],
                      brickBroken: controller.myBricks[0][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBricks[1][0],
                      brickY: controller.myBricks[1][1],
                      brickBroken: controller.myBricks[1][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBricks[2][0],
                      brickY: controller.myBricks[2][1],
                      brickBroken: controller.myBricks[2][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBricks[3][0],
                      brickY: controller.myBricks[3][1],
                      brickBroken: controller.myBricks[3][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBrickRow2[0][0],
                      brickY: controller.myBrickRow2[0][1],
                      brickBroken: controller.myBrickRow2[0][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBrickRow2[1][0],
                      brickY: controller.myBrickRow2[1][1],
                      brickBroken: controller.myBrickRow2[1][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBrickRow2[2][0],
                      brickY: controller.myBrickRow2[2][1],
                      brickBroken: controller.myBrickRow2[2][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                    MyBrick(
                      brickX: controller.myBrickRow2[3][0],
                      brickY: controller.myBrickRow2[3][1],
                      brickBroken: controller.myBrickRow2[3][2],
                      brickHeight: HomeController.brickHeight,
                      brickWidth: HomeController.brickWidth,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
