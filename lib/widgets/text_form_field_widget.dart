import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    this.prefixText,
    this.onTap,
    this.onChanged,
    this.initialValue,
    this.enabled = true,
    this.controller,
  });

  final String label;
  final String hint;
  final String? prefixText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onBackground.withOpacity(0.4),
              height: 1,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextFormField(
            onChanged: onChanged,
            style: textTheme.titleLarge,
            initialValue: initialValue,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              prefixText: prefixText,
              contentPadding: EdgeInsets.zero,
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}
