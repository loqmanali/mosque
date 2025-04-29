import 'package:flutter/material.dart';

import '../../theme/shadcn_theme.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? error;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final bool disabled;
  final TextDirection? textDirection;

  const Input({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.error,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.disabled = false,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ShadTheme.foreground,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: error != null ? ShadTheme.destructive : ShadTheme.border,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(ShadTheme.radius),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            enabled: !disabled,
            textDirection: textDirection,
            style: const TextStyle(
              fontSize: 16,
              color: ShadTheme.foreground,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: ShadTheme.mutedForeground,
              ),
              prefixIcon: prefix,
              suffixIcon: suffix,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: disabled ? ShadTheme.muted : ShadTheme.background,
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: const TextStyle(
              fontSize: 12,
              color: ShadTheme.destructive,
            ),
          ),
        ],
      ],
    );
  }
}
