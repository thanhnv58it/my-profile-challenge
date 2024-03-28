import 'package:flutter/material.dart';
import 'package:my_profile/config/theme.dart';

class OpenFlutterButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function() onPressed;
  final String title;
  final IconData? icon;
  final double iconSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const OpenFlutterButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.orange,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.orange,
    this.iconSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    EdgeInsetsGeometry edgeInsets = const EdgeInsets.all(0);
    if (width == null || height == null) {
      edgeInsets = const EdgeInsets.symmetric(horizontal: 44.0, vertical: 8.0);
    }
    return Padding(
      padding: edgeInsets,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: edgeInsets,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              boxShadow: [
                BoxShadow(
                    color: backgroundColor.withOpacity(0.3),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 5.0)),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildIcon(theme),
                _buildTitle(theme),
              ],
            ),
          ),
        ),
      ),
    );
    /*MaterialButton(
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(
          AppSizes.buttonRadius
        )
      ),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(title,
          style: _theme.textTheme.button?.copyWith(
            backgroundColor: _theme.textTheme.button.backgroundColor,
            color: _theme.textTheme.button.color
          )
        )
      )
    );*/
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        backgroundColor: theme.textTheme.titleMedium?.backgroundColor,
        color: textColor,
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: theme.textTheme.titleMedium?.color,
        ),
      );
    }

    return const SizedBox();
  }
}
