import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:workit/resources/api_calls.dart';
import 'package:workit/resources/constants.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
  late NfcTag tag;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
//Call NFC function. When authenticated, toggle card
    //_controller.toggleCard();
  }

  Future<void> writeTag() {
    final completer = Completer<void>();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag nfcTag) async {
        print('he found one');
        // Do something with an NfcTag instance.
        final ndef = Ndef.from(nfcTag);
        final formattable = NdefFormatable.from(nfcTag);
        final message = NdefMessage([NdefRecord.createText('1')]);
        if (ndef != null) {
          await ndef.write(message);
        } else if (formattable != null) {
          await formattable.format(message);
        }
        await NfcManager.instance.stopSession();
        completer.complete();
      },
      onError: (error) async => completer.completeError(error),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
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
        ),
        TextButton(
          child: Text('Request clock in'),
          onPressed: () async {
            try {
              String response = await requestShift(1);
              await writeTag();
            } catch (e) {
              print(e);
            }

            // Check availability
            //bool isAvailable = await NfcManager.instance.isAvailable();
          },
        ),
      ],
    );
  }
}
