import 'package:flutter/material.dart';

import '../../theme/shadcn_theme.dart';

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool isHoverable;

  const Card({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.isHoverable = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ShadTheme.duration,
      curve: ShadTheme.curve,
      decoration: BoxDecoration(
        color: ShadTheme.card,
        borderRadius: BorderRadius.circular(ShadTheme.radius),
        border: Border.all(color: ShadTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ShadTheme.radius),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
