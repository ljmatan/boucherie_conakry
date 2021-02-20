import 'package:flutter/material.dart';

class PeopleOption extends StatelessWidget {
  final int index, initial;
  final Stream stream;
  final Function setPersons;

  PeopleOption({
    @required this.index,
    @required this.initial,
    @required this.stream,
    @required this.setPersons,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: initial,
      builder: (context, selected) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: selected.data == index
                  ? Theme.of(context).accentColor
                  : Colors.grey,
              width: selected.data == index ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 5 - 19.2,
            height: MediaQuery.of(context).size.width / 5 - 19.2,
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontWeight: selected.data == index ? FontWeight.bold : null,
                  color: selected.data == index
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        onTap: () => setPersons(index),
      ),
    );
  }
}
