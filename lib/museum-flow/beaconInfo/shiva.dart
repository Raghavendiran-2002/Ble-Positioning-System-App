import 'package:flutter/material.dart';

class Shiva extends StatefulWidget {
  // const Shiva({Key? key}) : super(key: key);
  const Shiva({
    super.key,
    this.BuildingInfo,
    this.BuildingName,
  });

  final String? BuildingName;
  final String? BuildingInfo;
  @override
  State<Shiva> createState() => _ShivaState();
}

class _ShivaState extends State<Shiva> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              child: Text("${widget.BuildingName}"),
            ),
            Container(
              child: Text("${widget.BuildingInfo}"),
            )
          ],
        ),
      ),
    );
  }
}
