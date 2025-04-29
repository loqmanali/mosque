import 'package:flutter/material.dart';

import '../../theme/shadcn_theme.dart';

enum ButtonVariant { primary, secondary, destructive, outline, ghost, link }

enum ButtonSize { sm, md, lg, icon }

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool disabled;

  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || isLoading;

    return AnimatedOpacity(
      duration: ShadTheme.duration,
      opacity: isDisabled ? 0.5 : 1.0,
      child: Material(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(ShadTheme.radius),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(ShadTheme.radius),
          child: Container(
            padding: _getPadding(),
            decoration: _getDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading) ...[
                  SizedBox(
                    width: _getLoadingSize(),
                    height: _getLoadingSize(),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_getLoadingColor()),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                DefaultTextStyle(
                  style: TextStyle(
                    color: _getForegroundColor(),
                    fontSize: _getFontSize(),
                    fontWeight: FontWeight.w500,
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case ButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.icon:
        return const EdgeInsets.all(8);
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.sm:
        return 14;
      case ButtonSize.md:
        return 16;
      case ButtonSize.lg:
        return 18;
      case ButtonSize.icon:
        return 20;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.sm:
        return 14;
      case ButtonSize.md:
        return 16;
      case ButtonSize.lg:
        return 20;
      case ButtonSize.icon:
        return 16;
    }
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return ShadTheme.primary;
      case ButtonVariant.secondary:
        return ShadTheme.secondary;
      case ButtonVariant.destructive:
        return ShadTheme.destructive;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
      case ButtonVariant.link:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (variant) {
      case ButtonVariant.primary:
        return ShadTheme.primaryForeground;
      case ButtonVariant.secondary:
        return ShadTheme.secondaryForeground;
      case ButtonVariant.destructive:
        return ShadTheme.destructiveForeground;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
      case ButtonVariant.link:
        return ShadTheme.foreground;
    }
  }

  Color _getLoadingColor() {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.destructive:
        return ShadTheme.primaryForeground;
      case ButtonVariant.secondary:
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
      case ButtonVariant.link:
        return ShadTheme.primary;
    }
  }

  BoxDecoration _getDecoration() {
    switch (variant) {
      case ButtonVariant.outline:
        return BoxDecoration(
          border: Border.all(color: ShadTheme.border),
          borderRadius: BorderRadius.circular(ShadTheme.radius),
        );
      default:
        return const BoxDecoration();
    }
  }
}
