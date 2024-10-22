

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

Size getSize(context) {
  return MediaQuery.of(context).size;
}


void printDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}

void pushAndRemoveUntil(context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) =>  screen),
      (route) => false);
}

void push(context, Widget screen){
  Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) =>  screen));
}
