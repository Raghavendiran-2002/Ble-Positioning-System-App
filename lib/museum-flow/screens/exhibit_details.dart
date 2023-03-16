import 'package:flutter/material.dart';

class ExhibitDetails extends StatefulWidget {
  const ExhibitDetails({Key? key}) : super(key: key);

  @override
  State<ExhibitDetails> createState() => _ExhibitDetailsState();
}

class _ExhibitDetailsState extends State<ExhibitDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue.shade400,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Image.asset('assets/images/img1.png'),
        ),
      ),
    );
  }
}
