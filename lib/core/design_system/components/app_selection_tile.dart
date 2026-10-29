import 'package:flutter/material.dart';

import '../app_theme.dart';

/// A tappable, accessible option for settings and selection flows.
class AppSelectionTile extends StatelessWidget {
  const AppSelectionTile({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.enabled = true,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final borderColor = selected ? scheme.onSurface : theme.dividerColor;
    final backgroundColor = selected
        ? scheme.onSurface.withValues(alpha: 0.05)
        : scheme.surface;

    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled && onTap != null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: borderColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(AppRadius.large),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 56),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.x4,
                  vertical: AppSpacing.x3,
                ),
                child: Row(
                  children: [
                    if (leading != null) ...[
                      IconTheme(
                        data: IconThemeData(
                          color: enabled ? scheme.onSurface : scheme.onSurface.withValues(alpha: 0.38),
                          size: 22,
                        ),
                        child: leading!,
                      ),
                      const SizedBox(width: AppSpacing.x3),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: enabled
                                  ? scheme.onSurface
                                  : scheme.onSurface.withValues(alpha: 0.38),
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: AppSpacing.x1),
                            Text(
                              subtitle!,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.x3),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected ? scheme.onSurface : theme.dividerColor,
                          width: selected ? 6 : 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
