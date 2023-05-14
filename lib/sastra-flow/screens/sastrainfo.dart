import 'package:ble_positioning_system/home-flow/services/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SastraInfo extends StatefulWidget {
  const SastraInfo({Key? key}) : super(key: key);

  @override
  State<SastraInfo> createState() => _SastraInfoState();
}

class _SastraInfoState extends State<SastraInfo> {
  FlutterTts ftts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    speakText(
      "\nThe Centre for Information Super Highway is a part of the Centre of Relevance and Excellence (CORE) in Advanced Computing & Information Processing established by the Technology, Information, Forecasting & Assessment Council (TIFAC), Department of Science & Technology, Government of India. This facility at the School of Computing has been constantly upgraded to meet the academic and research needs of the entire campus. M/s Tata communications Lab for Cyber Security, Microsoft Technical Services Lab for Cloud, Tata Realty-Data Science Lab.",
    );
    super.initState();
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
            Image.asset(
              'assets/images/tifac.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "SASTRA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
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
                        Text(
                            "\nThe Shanmugha Arts, Science, Technology & Research Academy, also known as SASTRA, is a private and deemed university in the town of Thirumalaisamudram, Thanjavur district, Tamil Nadu, India. SASTRA is ranked by global ranking agencies such as Times Higher Education and QS."),
                        Image.asset(
                          'assets/images/ask.png',
                          fit: BoxFit.cover,
                        ),
                        Text(
                            "ESA/Keil MCB2140-ED ARM7 Single Board Evaluation Board -Philips LPC2140R"),
                        Image.asset(
                          'assets/images/Library.png',
                          fit: BoxFit.cover,
                        ),
                        Text(
                            "Waspmote WiFi on-chip Node, Expansion Board, Gases Sensor Board, Agriculture Sensor Board PRO, Advanced video camera sensor board, Events Sensor Board, Prototype Sensor Board, Gateway 802.15.4 2dBi, Radiation Sensor Board + Geiger Tube, Meshlium 4G 802.15.4 AP EU, Water mark Soil moisture sensor with 1.5 probe, Leaf Wetness Sensor, Soil/Water Temperature Sensor (Pt-1000), Air pollutants-II (NH3, H2S,CH3-Ch2-OH, C6H5CH3 Gas Sensor,"),
                        Image.asset(
                          'assets/images/CHANAKYA.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
