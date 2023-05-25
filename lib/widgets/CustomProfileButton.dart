import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../resources/constants.dart';
import 'CustomCupertinoButton.dart';

class CustomProfileButton extends StatefulWidget {
  const CustomProfileButton(
      {Key? key,
      required this.media,
      required this.title,
      required this.onPressed})
      : super(key: key);

  final MediaQueryData media;
  final String title;
  final VoidCallback? onPressed;

  @override
  State<CustomProfileButton> createState() => _CustomProfileButtonState();
}

class _CustomProfileButtonState extends State<CustomProfileButton> {
  @override
  Widget build(BuildContext context) {
    return CustomCupertinoButton(
      context: context,
      height: widget.media.size.height / 17,
      width: widget.media.size.width / 1.25,
      parentPadding: EdgeInsets.symmetric(horizontal: 15.0),
      backgroundColor: kGrey1,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          FaIcon(
            FontAwesomeIcons.angleRight,
            size: 15,
            color: kGrey4,
          ),
        ],
      ),
      onPressed: widget.onPressed,
    );
  }
}
