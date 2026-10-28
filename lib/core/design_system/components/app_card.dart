import 'package:flutter/material.dart';

import '../app_theme.dart';

/// A restrained surface for content that benefits from visual grouping.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.x4),
    this.semanticLabel,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: semanticLabel != null,
      label: semanticLabel,
      child: Card(
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
