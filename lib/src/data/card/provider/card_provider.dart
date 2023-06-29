import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool isDragging = false;
  Offset _position = Offset.zero;
  double _angle = 0;
  Offset get position => _position;
  Size _screenSize = Size.zero;
  double get angle => _angle;
  List<String> get urlImages => _urlImages;
  int _numberOfLikes = 0;
  int _numberOfDislikes = 0;
  int _numberOfSuperlikes = 0;
  int get numberofLikes => _numberOfLikes;
  int get numberofDislikes => _numberOfDislikes;
  int get numberofSuperlikes => _numberOfSuperlikes;
  void setScreenSize(Size screenSize) => _screenSize = screenSize;
  void startPosition(DragStartDetails details) {
    isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition() {
    isDragging = false;
    notifyListeners();
    final status = getStatus();
    if (status != null) {
      print(" nikhil");
      var res = status.toString().split('.').last.toUpperCase();
      print(status.toString().split('.').last.toUpperCase());
    }
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superlike:
        superLike();
        break;

      default:
        resetPosition();
    }
    resetPosition();
  }

  Future<void> loadCounts() async {
    final preferences = await SharedPreferences.getInstance();
    _numberOfLikes = preferences.getInt('numberOfLikes') ?? 0;
    _numberOfDislikes = preferences.getInt('numberOfDislikes') ?? 0;
    _numberOfSuperlikes = preferences.getInt('numberOfSuperLikes') ?? 0;
    notifyListeners();
  }

  Future<void> saveCounts() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt('numberOfLikes', _numberOfLikes);
    preferences.setInt('numberOfDislikes', _numberOfDislikes);
    preferences.setInt('numberOfSuperLikes', _numberOfSuperlikes);
  }

  void resetPosition() {
    isDragging = false;

    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;
    final delta = 100;
    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    } else if (y >= delta / 1.5 && forceSuperLike) {
      return CardStatus.superlike;
    }
  }

  void like() async {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);

    _numberOfLikes++;

    notifyListeners();
    await saveCounts();
  }

  void dislike() async {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);

    _numberOfDislikes++;

    notifyListeners();
    await saveCounts();
  }

  void superLike() async {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);

    _numberOfSuperlikes++;

    notifyListeners();
    await saveCounts();
  }
}

enum CardStatus { like, dislike, superlike }
