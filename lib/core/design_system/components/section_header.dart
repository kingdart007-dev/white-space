import 'package:flutter/material.dart';

import '../app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.description,
    this.trailing,
    super.key,
  });

  final String title;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = this.description;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              if (description != null) ...[
                const SizedBox(height: AppSpacing.x2),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSpacing.x3),
          trailing!,
        ],
      ],
    );
  }
}
