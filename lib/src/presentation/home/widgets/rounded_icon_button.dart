import 'package:flutter/material.dart';

class RoundedIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const RoundedIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  _RoundedIconButtonState createState() => _RoundedIconButtonState();
}

class _RoundedIconButtonState extends State<RoundedIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: widget.icon,
        ),
      ),
    );
  }
}
