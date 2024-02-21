import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.icon,
      required this.title,
      required this.textStyle,
      this.radius = 8.0,
      required this.onTap,
      this.margin,
      this.padding,
      this.height = 48,
      this.width = double.maxFinite,
      this.backgroundColor,
      this.isEnable = true,
      this.isLoading = false,
      this.borderColor});
  final Widget? icon;
  final String title;
  final TextStyle? textStyle;
  final double? radius;
  final Function() onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isEnable;
  final double height;
  final double? width;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == false || isEnable == true ? onTap : null,
      radius: radius,
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: isEnable ? backgroundColor : Colors.grey.shade200,
            border: isEnable
                ? Border.all(
                    color: borderColor ?? backgroundColor ?? Colors.black)
                : null,
            borderRadius: BorderRadius.circular(
              radius ?? 8.0,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLoading == true
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )),
                  )
                : icon ?? const SizedBox.shrink(),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
