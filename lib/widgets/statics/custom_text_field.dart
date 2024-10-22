import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nex_lab/helpers/consts.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.icon,
    super.key,
    required this.label,
    this.hint,
    required this.textEditingController,
    required this.validate,
    this.secureText = false,
    this.isEnabled = true,
    this.keyboardType,
    this.inputFormatters,
  });

  final String? label;
  final String? hint;
  final Icon? icon;
  final TextEditingController textEditingController;
  final FormFieldValidator<String?> validate;
  final bool secureText;
  final bool isEnabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          obscureText: widget.secureText,
          onChanged: (value) {
            value = widget.textEditingController.text;
          },
          controller: widget.textEditingController,
          validator: widget.validate,
          enabled: widget.isEnabled,
           keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  widget.icon ?? const SizedBox(),
                  Container(
                    height: 24,
                    width: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  ),
                ],
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: mainColor)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: widget.label,
              fillColor: Colors.black.withOpacity(0.08),
              filled: true),
        ),
      ),
    );
  }
}
