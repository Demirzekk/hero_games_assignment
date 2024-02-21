import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.icon,
      required this.child,
      required this.onPressed,
      this.height = 48,
      this.width = double.maxFinite,
      this.backgroundColor,
      this.foregroundColor,
      this.borderColor = const Color.fromRGBO(193, 199, 208, 1),
      this.margin,
      this.isEnable = true,
      this.isBorder = false,
      this.isIconLeft = true,
      this.elevation,
      this.borderRadius = 8});
  final Widget? icon;
  final Widget child;
  final Function() onPressed;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? margin;
  final bool isBorder;
  final bool isEnable;
  final double? elevation;
  final double? borderRadius;
  final bool? isIconLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(0.0),
      child: icon == null
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey.shade200,
                  alignment: Alignment.center,
                  elevation: elevation ?? 0,
                  foregroundColor:
                      foregroundColor ?? const Color.fromRGBO(78, 93, 120, 1),
                  backgroundColor: isEnable == false
                      ? Colors.grey.shade200
                      : backgroundColor ?? Colors.white,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: isBorder ? borderColor : Colors.transparent,
                          width: 1),
                      borderRadius: BorderRadius.circular(borderRadius ?? 8))),
              onPressed: isEnable ? onPressed : null,
              child: child,
            )
          : Directionality(
              textDirection:
                  isIconLeft == true ? TextDirection.ltr : TextDirection.rtl,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor: Colors.grey.shade200,
                      foregroundColor: foregroundColor ??
                          const Color.fromRGBO(78, 93, 120, 1),
                      backgroundColor: isEnable == false
                          ? Colors.grey.shade200
                          : backgroundColor ?? Colors.white,
                      minimumSize: Size(width, height),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color:
                                  isBorder ? borderColor : Colors.transparent,
                              width: 1),
                          borderRadius:
                              BorderRadius.circular(borderRadius ?? 8))),
                  onPressed: isEnable ? onPressed : null,
                  icon: icon ?? const SizedBox.shrink(),
                  label: child),
            ),
    );
  }
}
