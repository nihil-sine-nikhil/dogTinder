import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/card/provider/card_provider.dart';

class DogCard extends StatefulWidget {
  final String urlImage;
  const DogCard({
    super.key,
    required this.urlImage,
  });

  @override
  State<DogCard> createState() => _DogCardState();
}

class _DogCardState extends State<DogCard> {
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
          final milliseconds = provider.isDragging ? 0 : 400;
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
