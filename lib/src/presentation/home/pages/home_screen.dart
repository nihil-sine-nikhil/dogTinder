import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/src/app/constants/ui_constants.dart';

import '../../../app/constants/app_constants.dart';
import '../../../data/dog/bloc/dog_bloc.dart';
import '../../../data/user/bloc/user_bloc.dart';
import '../../widgets/dancing_dots.dart';
import '../widgets/rounded_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogBloc, DogState>(
      builder: (context, state) {
        return Scaffold(
            body: (state is DogImageLoaded)
                ? SafeArea(
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      TinderCard(
                        urlImage: state.dog!.pic!,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kRed,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofDislikes.toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kBlue,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofLikes.toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kBlack,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofSuperlikes
                                          .toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserProfileLoaded) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          txt: "Hi!",
                                          fontSize: 20,
                                          color: kWhite,
                                          weight: FontWeight.w500),
                                      poppinsText(
                                          txt: state.userProfile.name,
                                          fontSize: 20,
                                          maxLines: 2,
                                          color: kWhite,
                                          weight: FontWeight.w700),
                                    ],
                                  );
                                }
                                return JumpingDots();
                              },
                            )
                          ],
                        ),
                      )
                    ]),
                  )
                : Center(
                    child: JumpingDots(),
                  ));
      },
    );
  }
}

class TinderCard extends StatefulWidget {
  final String urlImage;
  const TinderCard({
    super.key,
    required this.urlImage,
  });

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: buildFrontCard(),
    );
  }

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(builder: (context, constraints) {
          final provider = Provider.of<CardProvider>(context);
          final position = provider.position;
          final milliseconds = provider._isDragging ? 0 : 400;
          final angle = provider.angle * pi / 180;
          final center = constraints.smallest.center(Offset.zero);
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix
                ..translate(
                  position.dx,
                  position.dy,
                ),
              child: buildCard());
        }),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.endPosition();
        },
      );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.urlImage), fit: BoxFit.cover),
        ),
        alignment: Alignment(-0.3, 0),
      ));
}

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
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
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
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

  void resetPosition() {
    _isDragging = false;

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
    SharedPreferences sp = await SharedPreferences.getInstance();
    final number = sp.getInt(AppConstant.spTotalLikes);
    sp.setInt(AppConstant.spTotalLikes, number! + 1);
    _numberOfLikes++;

    notifyListeners();
  }

  void dislike() async {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    SharedPreferences sp = await SharedPreferences.getInstance();
    final number = sp.getInt(AppConstant.spTotalDislikes);
    sp.setInt(AppConstant.spTotalDislikes, number! + 1);
    _numberOfDislikes++;

    notifyListeners();
  }

  void superLike() async {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    SharedPreferences sp = await SharedPreferences.getInstance();
    final number = sp.getInt(AppConstant.spTotalSuperLikes);
    sp.setInt(AppConstant.spTotalSuperLikes, number! + 1);
    _numberOfSuperlikes++;

    notifyListeners();
  }
}

enum CardStatus { like, dislike, superlike }
