import 'package:ble_positioning_system/home-flow/services/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EmbeddedInfo extends StatefulWidget {
  const EmbeddedInfo({Key? key}) : super(key: key);

  @override
  State<EmbeddedInfo> createState() => _EmbeddedInfoState();
}

class _EmbeddedInfoState extends State<EmbeddedInfo> {
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    super.initState();
    speakText(
        "Embedded Development Boards:  ESA/Keil MCB2140-ED ARM7 Single Board Evaluation Board -Philips LPC2140  ESA/Keil MCB1760-ED Cortex M3 Series  Keil MCB2370-ED SBC / Evaluation Board for NXP LPC237x ARM7 series  Keil MCBSTM32F400-ED SBC / Cortex M4 Evaluation Boards  Keil ULINK PRO-ED High Speed Debug and Trace Unit  ESA/Segger 8.08.90 JTAG Emulator For ARM Cores  DEI-SOC Boards");
  }

  void speakText(String voice) async {
    await ftts.speak(voice);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theming.instance.isLight
            ? Theming.instance.Light["appBarBgColor"]
            : Theming.instance.Dark["appBarBgColor"],
        body: Column(
          children: [
            // Container(
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20), // Image border
            //   child: SizedBox.fromSize(
            //     size: Size.fromRadius(48), // Image radius
            //     child: Image.network('imageUrl', fit: BoxFit.cover),
            //   ),
            // ),
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
                  color: Theming.instance.isLight
                      ? Theming.instance.Light["appBarBgColor"]
                      : Theming.instance.Dark["appBarBgColor"],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Embedded System Lab",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Text(
                          "\nThe Centre for Information Super Highway is a part of the Centre of Relevance and Excellence (CORE) in Advanced Computing & Information Processing established by the Technology, Information, Forecasting & Assessment Council (TIFAC), Department of Science & Technology, Government of India. This facility at the School of Computing has been constantly upgraded to meet the academic and research needs of the entire campus. M/s Tata communications Lab for Cyber Security, Microsoft Technical Services Lab for Cloud, Tata Realty-Data Science Lab.",
                        ),
                        Image.asset(
                          'assets/images/tifacimg1.png',
                          fit: BoxFit.cover,
                        ),
                        Text(
                            "ESA/Keil MCB2140-ED ARM7 Single Board Evaluation Board -Philips LPC2140R"),
                        Image.asset(
                          'assets/images/tifacimg2.png',
                          fit: BoxFit.cover,
                        ),
                        Text(
                            "Waspmote WiFi on-chip Node, Expansion Board, Gases Sensor Board, Agriculture Sensor Board PRO, Advanced video camera sensor board, Events Sensor Board, Prototype Sensor Board, Gateway 802.15.4 2dBi, Radiation Sensor Board + Geiger Tube, Meshlium 4G 802.15.4 AP EU, Water mark Soil moisture sensor with 1.5 probe, Leaf Wetness Sensor, Soil/Water Temperature Sensor (Pt-1000), Air pollutants-II (NH3, H2S,CH3-Ch2-OH, C6H5CH3 Gas Sensor,"),
                        Image.asset(
                          'assets/images/tifacimg2.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
