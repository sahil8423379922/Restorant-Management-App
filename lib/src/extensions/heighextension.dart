import 'package:flutter/material.dart';

extension SmartHeight on double {
  SizedBox height() {
    return SizedBox(
      height: this,
    );
  }

  SizedBox width() {
    return SizedBox(
      width: this,
    );
  }
}
