import 'dart:async';

import 'package:get/get.dart';

enum Direction { UP, DOWN, LEFT, RIGHT }

class HomeController extends GetxController {
  //TODO: Implement HomeController

//ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.02;
  double ballYincrements = 0.01;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

//player variables
  double playerX = -0.2;
  double playerWidth = 0.4; //out of 2

  //brick variables
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double secondBrickX = -1 + wallGap;
  static double secondBrickY = -0.8;
  static double brickWidth = 0.4; //out of 2
  static double brickHeight = 0.05; //out of 2
  static double brickGap = 0.05;
  static int numberOfBricksInRow = 4;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  List myBricks = [
    // [x, y, broken= true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 3 * (brickWidth + brickGap), firstBrickY, false],
  ];

  List myBrickRow2 = [
// [x, y, broken= true/false]
    [secondBrickX + 0 * (brickWidth + brickGap), secondBrickY, false],
    [secondBrickX + 1 * (brickWidth + brickGap), secondBrickY, false],
    [secondBrickX + 2 * (brickWidth + brickGap), secondBrickY, false],
    [secondBrickX + 3 * (brickWidth + brickGap), secondBrickY, false],
  ];

  //game settings
  bool hasGameStarted = false;
  bool isGameOver = false;
  bool isBallInMotion = false;
  bool hasPlayerWon = false;

//start game
  void startGame() {
    if (!isBallInMotion) {
      isBallInMotion = true;
      hasGameStarted = true;
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        //update direction
        updateDirection();
        //move ball
        moveBall();
        //check if player dead
        if (isPlayerDead()) {
          timer.cancel();
          isGameOver = true;
        }
        // Check if all bricks are broken and handle player win
        if (areAllBricksBroken()) {
          timer.cancel();
          hasPlayerWon = true;
        }
        //check if brick is hit
        checkForBrokenBricks();
      });
    }
  }

// function to check if all bricks are broken or not
  bool areAllBricksBroken() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2]) {
        return false; // If any brick is not broken, return false
      }
    }
    return true; // All bricks are broken
  }

  void checkForBrokenBricks() {
    // Function to check if a brick is broken and update the game state
    void checkBrick(List brickList) {
      for (int i = 0; i < brickList.length; i++) {
        if (ballX >= brickList[i][0] &&
            ballX <= brickList[i][0] + brickWidth &&
            ballY <= brickList[i][1] + brickHeight &&
            !brickList[i][2]) {
          brickList[i][2] = true;

          // Call the player win function when all bricks are broken
          if (areAllBricksBroken()) {
            hasPlayerWon = true;
          }

          // since brick is broken, update direction of ball based on which side of the brick it hit
          // to do this, calculate the distance of the ball from each of the 4 sides.
          // the smallest distance is the side the ball has hit
          
          double leftSideDist = (brickList[i][0] - ballX).abs();
          double rightSideDist = (brickList[i][0] + brickWidth - ballX).abs();
          double topSideDist = (brickList[i][1] - ballY).abs();
          double bottomSideDist = (brickList[i][1] + brickHeight - ballY).abs();

          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);

          switch (min) {
            case 'left':
              ballXDirection = Direction.LEFT;
              break;
            case 'right':
              ballXDirection = Direction.RIGHT;
              break;
            case 'up':
              ballYDirection = Direction.UP;
              break;
            case 'down':
              ballYDirection = Direction.DOWN;
              break;
          }
        }
      }
    }

    // Check for both MyBricks and MyBrickRow2
    checkBrick(myBricks);
    checkBrick(myBrickRow2);

    // Update the UI
    update();
  }

  //return the smallest side
  String findMin(double a, double b, double c, double d) {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];
    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'up';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'down';
    }

    return '';
  }

//is player dead
  bool isPlayerDead() {
    //player dies if ball reaches the bottom of screen
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  //move ball
  void moveBall() {
    //move horizontally
    if (ballXDirection == Direction.LEFT) {
      ballX -= ballXincrements;
    } else if (ballXDirection == Direction.RIGHT) {
      ballX += ballXincrements;
    }
    //move vertically
    if (ballYDirection == Direction.DOWN) {
      ballY += ballYincrements;
    } else if (ballYDirection == Direction.UP) {
      ballY -= ballYincrements;
    }
    update();
  }

//update direction of the ball
  void updateDirection() {
    //ball goes up when it hits player
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = Direction.UP;
      //ball goes down if it hits top of screen
    } else if (ballY <= -1) {
      ballYDirection = Direction.DOWN;
    }
    //ball goes left when it hits right wall
    if (ballX >= 1) {
      ballXDirection = Direction.LEFT;
    }
    //ball goes right when it hits left wall
    else if (ballX <= -1) {
      ballXDirection = Direction.RIGHT;
    }
    update();
  }

//move player left
  void moveLeft() {
    //only move left if moving left doesn't move playe off the screen
    if (!(playerX - 0.2 < -1)) {
      playerX -= 0.2;
    }

    update();
  }

  //move player right
  void moveRight() {
    //only move left if moving left doesn't move playe off the screen
    if (!(playerX + playerWidth >= 1)) {
      playerX += 0.2;
    }

    update();
  }

  // reset game back to initial values when user hits play again
  void resetGame() {
    playerX = -0.2;
    ballX = 0;
    ballY = 0;
    isGameOver = false;
    hasGameStarted = false;
    hasPlayerWon = false;
    isBallInMotion = false; // Reset the flag
    ballXincrements = 0.02; // Reset ball speed
    ballYincrements = 0.01;
    myBricks = [
      // [x, y, broken= true/false]
      [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
      [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
      [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
      [firstBrickX + 3 * (brickWidth + brickGap), firstBrickY, false],
    ];
    myBrickRow2 = [
// [x, y, broken= true/false]
      [secondBrickX + 0 * (brickWidth + brickGap), secondBrickY, false],
      [secondBrickX + 1 * (brickWidth + brickGap), secondBrickY, false],
      [secondBrickX + 2 * (brickWidth + brickGap), secondBrickY, false],
      [secondBrickX + 3 * (brickWidth + brickGap), secondBrickY, false],
    ];
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
