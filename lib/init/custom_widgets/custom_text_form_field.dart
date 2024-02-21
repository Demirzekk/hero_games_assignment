import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.suffixText,
    this.keyboardType,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.decoration,
    this.prefixIcon,
    this.fillColor,
    this.border,
    this.isDense = false,
    this.height,
    this.textAlign,
    this.inputFormatters,
    this.obscuretext = false,
    this.margin = const EdgeInsets.only(bottom: 12),
    this.onTap,
    this.enable = true,
    this.autofocus = false,
    this.suffixIcon,
    this.helperText,
    this.maxLines = 1,
  });
  final int maxLines;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isDense;
  final Color? fillColor;
  final InputBorder? border;
  final double? height;
  final TextAlign? textAlign;
  final bool obscuretext;
  final EdgeInsets margin;
  final Function()? onTap;
  final bool? enable;
  final bool autofocus;
  final String? helperText;

  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        height: height,
        child: TextFormField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          autofocus: autofocus,
          controller: controller,
          textAlign: textAlign ?? TextAlign.start,
          onChanged: onChanged,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: inputFormatters,
          obscureText: obscuretext,
          enabled: enable,
          onTap: onTap,
          maxLines: maxLines,
          decoration: decoration ??
              InputDecoration(
                  enabledBorder: border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                  border: border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[400]!,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  isDense: isDense,
                  fillColor: fillColor ?? Colors.grey[200],
                  filled: true,
                  hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                  labelText: labelText,
                  prefixIcon: prefixIcon,
                  helperText: helperText,
                  suffixText: suffixText,
                  suffixIcon: suffixIcon,
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w500),
                  hintText: hintText,
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always),
          validator: validator,
        ),
      ),
    );
  }
}

 
 
class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    Key? key,
    required this.text,
    this.textAlign,
    this.padding = const EdgeInsets.all(6.0),
    this.textStyle = const TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
  }) : super(key: key);
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(6.0),
      child: Text(text, textAlign: textAlign, style: textStyle),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    required this.textStyle,
    required this.onTap,
    this.title2,
    this.textStyle2,
  });

  final String title;
  final String? title2;
  final TextStyle? textStyle;
  final TextStyle? textStyle2;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: textStyle,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title2 ?? "",
              style: textStyle2,
            ),
          ],
        ));
  }
}


