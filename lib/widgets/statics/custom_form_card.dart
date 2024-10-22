import 'package:flutter/material.dart';

class CustomFormCard extends StatefulWidget {
  const CustomFormCard({super.key,
  required this.width,
  required this.height,
  required this.child,
  
  });

  final double width;
  final double height;
  final Widget child;

  @override
  State<CustomFormCard> createState() => _CustomFormCardState();
}

class _CustomFormCardState extends State<CustomFormCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadows: const [
            BoxShadow(
            color: Colors.black26,
            blurRadius: 60,
            offset: Offset(0, 30),
            spreadRadius: 0,
          )
        ],
      ),
      child: widget.child,
    );
  }
}
