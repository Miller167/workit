import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workit/resources/constants.dart';

//  ------------------- PUNCH CLOCK SCREEN --------------------
//  This is another option of the navBar. It is the NFC module.
//  On the center of the screen we see a card with the instruction
//  to approach the smartphone to the  nfc terminal. When authenticated,
//  the card flips and shows an approval message.

class PunchClockScreen extends StatefulWidget {
  const PunchClockScreen({Key? key}) : super(key: key);

  @override
  State<PunchClockScreen> createState() => _PunchClockScreenState();
}

class _PunchClockScreenState extends State<PunchClockScreen> {
  late FlipCardController _controller;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool clockedCorrectly = true;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
    //Call NFC function. When authenticated, toggle card
    //_controller.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Center(
      child: FlipCard(
        key: cardKey,
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.VERTICAL,
        flipOnTouch: true, // default
        front: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          height: media.height / 1.7,
          width: media.width / 1.3,
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 30, horizontal: media.width / 20),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      'Move the phone closer to the terminal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: media.width / 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: media.width / 15),
                  Expanded(
                    child: Icon(
                      Icons.nfc_outlined,
                      size: 60,
                      color: kGrey1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          height: media.height / 1.7,
          width: media.width / 1.3,
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 30, horizontal: media.width / 20),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      clockedCorrectly
                          ? 'Succesfully clocked in/out'
                          : 'There has been an error while clocking in/out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: media.width / 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: media.width / 15),
                  Expanded(
                    child: Icon(
                      clockedCorrectly ? Icons.check : Icons.close_rounded,
                      size: 60,
                      color: kGrey1,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
