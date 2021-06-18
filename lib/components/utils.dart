import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PopUpMessage {
  static showToast(String message, BuildContext context) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
