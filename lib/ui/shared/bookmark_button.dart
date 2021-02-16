import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'package:flutter/material.dart';

class BookmarkButton extends StatefulWidget {
  final String id;

  BookmarkButton({@required this.id});

  @override
  State<StatefulWidget> createState() {
    return _BookmarkButtonState();
  }
}

class _BookmarkButtonState extends State<BookmarkButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scale;

  bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    _scale = Tween<double>(begin: 1.2, end: 1).animate(_animationController);
    _animationController.value = 1;
    _bookmarked = Prefs.instance.getBool(widget.id) ?? false;
  }

  void _bookmark() {
    _bookmarked = !_bookmarked;
    _animationController.reset();
    _animationController.forward();
    Prefs.instance.setBool(widget.id, _bookmarked ? true : null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Transform.scale(
        scale: _scale.value,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: _bookmarked
              ? Icon(
                  Icons.bookmark,
                  size: 30,
                  color: Theme.of(context).accentColor,
                )
              : const Icon(
                  Icons.bookmark_outline,
                  size: 30,
                ),
          onTap: () => _bookmark(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
