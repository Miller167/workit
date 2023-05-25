import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  BuildContext context;
  double height;
  double width;
  Color? color;
  Widget? content;
  double borderRadius;
  EdgeInsets parentMargin;
  EdgeInsets parentPadding;
  EdgeInsets childMargin;
  EdgeInsets childPadding;

  CustomContainer(
      {Key? key,
      required this.context,
      required this.height,
      required this.width,
      this.color = Colors.white,
      required this.content,
      this.borderRadius = 20,
      this.parentMargin = const EdgeInsets.all(0),
      this.parentPadding = const EdgeInsets.all(0),
      this.childMargin = const EdgeInsets.all(0),
      this.childPadding = const EdgeInsets.all(0)})
      : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.parentMargin,
      padding: widget.parentPadding,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: kElevationToShadow[6]),
      child: Container(
        margin: widget.childMargin,
        padding: widget.childPadding,
        child: widget.content,
      ),
    );
  }
}
