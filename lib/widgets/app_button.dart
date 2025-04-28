import 'package:flutter/material.dart';
import '../theme/dimens.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final ButtonStyle style = isOutlined
        ? OutlinedButton.styleFrom(
      foregroundColor: textColor ?? theme.primaryColor,
      side: BorderSide(color: theme.primaryColor),
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingSmall,
        horizontal: AppDimens.paddingMedium,
      ),
      minimumSize: Size(width ?? double.infinity, AppDimens.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
      ),
    )
        : ElevatedButton.styleFrom(
      foregroundColor: textColor ?? Colors.white,
      backgroundColor: backgroundColor ?? theme.primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingSmall,
        horizontal: AppDimens.paddingMedium,
      ),
      minimumSize: Size(width ?? double.infinity, AppDimens.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusMedium),
      ),
    );

    final Widget child = isLoading
        ? SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: isOutlined ? theme.primaryColor : Colors.white,
      ),
    )
        : Text(label);

    return isOutlined
        ? OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: child,
    )
        : ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: child,
    );
  }
}