import 'package:flutter/material.dart';

class EmbeddedInfo extends StatefulWidget {
  const EmbeddedInfo({Key? key}) : super(key: key);

  @override
  State<EmbeddedInfo> createState() => _EmbeddedInfoState();
}

class _EmbeddedInfoState extends State<EmbeddedInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFC9C5B4),
        body: Column(
          children: [
            // Container(
            Image.asset(
              'assets/images/EmbeddedLab.png',
              fit: BoxFit.cover,
            ),
            // ),
            Expanded(
              flex: 1,
              child: Container(
                // color: Colors.black12,R
                // width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0)),
                  color: Colors.lime,
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                        "Embedded Development Boards:  ESA/Keil MCB2140-ED ARM7 Single Board Evaluation Board -Philips LPC2140 ESA/Keil MCB1760-ED Cortex M3 Series Keil MCB2370-ED SBC / Evaluation Board for NXP LPC237x ARM7 series Keil MCBSTM32F400-ED SBC / Cortex M4 Evaluation Boards Keil ULINK PRO-ED High Speed Debug and Trace Unit ESA/Segger 8.08.90 JTAG Emulator For ARM Core  DEI-SOC Boards")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
