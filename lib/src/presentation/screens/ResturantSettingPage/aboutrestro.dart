import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AboutRestro extends StatefulWidget {
  final String para;
  const AboutRestro({Key? key, required this.para}) : super(key: key);

  @override
  State<AboutRestro> createState() => _AboutRestroState();
}

class _AboutRestroState extends State<AboutRestro> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          child: Text(
        widget.para,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      )),
    );
  }
}
