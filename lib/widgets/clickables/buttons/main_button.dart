import 'package:flutter/material.dart';
import 'package:nex_lab/helpers/consts.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.inProgress = false,
      this.btnColor = mainColor,
      this.txtColor = Colors.white,
      this.borderColor = mainColor});
  final String text;
  final Function onPressed;
  final bool inProgress;
  final Color btnColor;
  final Color txtColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(color: borderColor, width: 2),
            backgroundColor: btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () => onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inProgress
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: txtColor.withOpacity(0.5),
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(
                            color: txtColor, fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          )),
    );
  }
}
