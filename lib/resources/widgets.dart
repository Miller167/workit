import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

//  ----------------- WIDGETS -----------------
//  File where we save most used widgets and called throughout the file

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

class CustomContainer extends StatefulWidget {
  BuildContext context;
  double height;
  double width;
  Color backgroundColor;
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
      required this.backgroundColor,
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
          color: widget.backgroundColor,
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

class CustomProfileButton extends StatefulWidget {
  const CustomProfileButton({
    Key? key,
    required this.media,
    required this.title,
  }) : super(key: key);

  final MediaQueryData media;
  final String title;

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
            style: Theme.of(context).textTheme.headline2,
          ),
          FaIcon(
            FontAwesomeIcons.angleRight,
            size: 15,
            color: kGrey4,
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

class customOverviewEventTile extends StatefulWidget {
  customOverviewEventTile(
      {Key? key,
      required this.color,
      required this.height,
      required this.width,
      this.childMargin = const EdgeInsets.all(0),
      this.childPadding = const EdgeInsets.all(0),
      required this.title,
      required this.description,
      required this.startHour,
      required this.endHour})
      : super(key: key);

  Color color;
  double height;
  double width;
  EdgeInsets childMargin;
  EdgeInsets childPadding;
  String title;
  String description;
  String startHour;
  String endHour;

  @override
  State<customOverviewEventTile> createState() =>
      _customOverviewEventTileState();
}

class _customOverviewEventTileState extends State<customOverviewEventTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          CustomContainer(
            context: context,
            height: widget.height,
            width: widget.width,
            backgroundColor: widget.color,
            content: null,
          ),
          Positioned(
            right: 0,
            child: Container(
              height: widget.height,
              width: widget.width - 25,
              //margin: widget.childMargin,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: kGrey1,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: kElevationToShadow[6],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    child: Text(
                      widget.description,
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          size: 15,
                          color: kGrey4,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${widget.startHour} - ${widget.endHour}',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
