import 'package:flutter/material.dart';

class AnimatedFood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimatedFoodState();
  }
}

class _AnimatedFoodState extends State<AnimatedFood>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _rotation;

  bool _animated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() => setState(() {}));
    _rotation = Tween<double>(begin: 1, end: 6).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _animated = true;
        _animationController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 600),
          left: _animated ? -50 : -200,
          bottom: _animated ? -50 : -200,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Image.asset(
              'assets/images/tomatoes.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 600),
          right: _animated ? -50 : -200,
          top: _animated ? -50 : -200,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Image.asset(
              'assets/images/salt.png',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ],
    );
  }
}
