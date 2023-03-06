import 'dart:math';
import 'package:flutter/material.dart';

import 'security_tile.dart';

class CustomSecurityKeyboard extends StatefulWidget {
  const CustomSecurityKeyboard(
      {
        Key? key,
        required this.onPressed,
        this.row = 4,
        this.column = 3
      }) : super(key: key);

  final Function(int) onPressed;

  final int row;
  final int column;

  @override
  State<CustomSecurityKeyboard> createState() => _CustomSecurityKeyboardState();
}

class _CustomSecurityKeyboardState extends State<CustomSecurityKeyboard> {

  late List<int> randomNumber = List.empty(growable: true);
  late List<int> randomResult = List.empty(growable: true);

  void setRandomNumber() {
    randomNumber.clear();
    for(int i = 0; i < (widget.row * widget.column) - 2; i++) {
      randomNumber.add(i);
    }
  }

  void getRandomNumber() {
    setRandomNumber();
    randomResult.clear();
    for(int i = 0; i < (widget.row * widget.column) - 2; i++) {
      int rand = Random.secure().nextInt(randomNumber.length);
      int result = randomNumber[rand];
      randomResult.add(result);
      randomNumber.removeAt(rand);
    }
  }

  void refresh() {
    getRandomNumber();
    setState(() { });
  }

  @override
  void initState() {
    getRandomNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.column,
        itemBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.width / widget.row,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.row,
                itemBuilder: (c, i) {
                  if((index * widget.row) + i == widget.row * widget.column - 1) {
                    return SecurityTile(
                      row: widget.row,
                      column: widget.column,
                      content: const Icon(Icons.backspace),
                      onPressed: () => widget.onPressed(-2),
                    );
                  }else if((index * widget.row) + i == widget.row * widget.column - 2) {
                    return SecurityTile(
                      row: widget.row,
                      column: widget.column,
                      content: const Icon(Icons.refresh),
                      onPressed: () {
                        widget.onPressed(-1);
                        refresh();
                      },
                    );
                  }else {
                    return SecurityTile(
                      row: widget.row,
                      column: widget.column,
                      content: Text('${randomResult[(index * widget.row) + i]}'),
                      onPressed: () => widget.onPressed(randomResult[(index * widget.row) + i]),
                    );
                  }
                }
            ),
          );
        }
    );
  }
}



