import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../resources/constants.dart';
import 'CustomContainer.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: CustomContainer(
        context: context,
        height: widget.height,
        width: widget.width,
        content: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.circle,
                            size: 15,
                            color: widget.color,
                          )),
                      Container(
                        child: Expanded(
                          child: Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
