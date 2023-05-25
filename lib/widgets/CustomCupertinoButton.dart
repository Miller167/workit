import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomCupertinoButton extends StatefulWidget {
  BuildContext context;
  double height;
  double width;
  Color backgroundColor;
  Widget? content;
  VoidCallback? onPressed;
  double borderRadius;
  EdgeInsets parentMargin;
  EdgeInsets parentPadding;
  EdgeInsets childMargin;
  EdgeInsets childPadding;

  CustomCupertinoButton(
      {Key? key,
      required this.context,
      required this.height,
      required this.width,
      required this.backgroundColor,
      required this.content,
      required this.onPressed,
      this.borderRadius = 20,
      this.parentMargin = const EdgeInsets.all(0),
      this.parentPadding = const EdgeInsets.all(0),
      this.childMargin = const EdgeInsets.all(0),
      this.childPadding = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  State<CustomCupertinoButton> createState() => _CustomCupertinoButtonState();
}

class _CustomCupertinoButtonState extends State<CustomCupertinoButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.onPressed,
      child: Container(
        margin: widget.parentMargin,
        padding: widget.parentPadding,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: kElevationToShadow[6]),
        child: Container(
          margin: widget.childMargin,
          padding: widget.childPadding,
          child: widget.content,
        ),
      ),
    );
  }
}
