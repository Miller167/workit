import 'package:flutter/material.dart';

import 'CustomContainer.dart';

class customOverviewTaskTile extends StatefulWidget {
  customOverviewTaskTile(
      {Key? key,
      required this.height,
      required this.width,
      required this.title})
      : super(key: key);

  double height;
  double width;
  String title;

  @override
  State<customOverviewTaskTile> createState() => _customOverviewTaskTileState();
}

class _customOverviewTaskTileState extends State<customOverviewTaskTile> {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
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
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    child: Icon(Icons.circle_outlined, size: media.width / 25)),
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 2.5),
                  child: Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                //TextButton(onPressed: () {}, child: Text('...')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
