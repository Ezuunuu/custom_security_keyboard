import 'package:flutter/material.dart';

class SecurityTile extends StatelessWidget {
  const SecurityTile(
      {
        Key? key,
        required this.content,
        required this.onPressed,
        this.backgroundColor,
        this.borderColor,
        this.row = 4,
        this.column = 3,
      }) : super(key: key);

  final Widget content;
  final Function onPressed;
  final Color? backgroundColor;
  final Color? borderColor;

  final int row;
  final int column;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.zero)
      ),
      onPressed: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
            border: Border(
              bottom: BorderSide(color: borderColor ?? Colors.white),
              left: BorderSide(color: borderColor ?? Colors.white),
            )
        ),
        width: MediaQuery.of(context).size.width / row,
        height: MediaQuery.of(context).size.width / row,
        child: Center(child: content),
      ),
    );
  }
}