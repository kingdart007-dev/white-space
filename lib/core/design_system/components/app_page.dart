import 'package:flutter/material.dart';

import '../app_theme.dart';

/// A consistent, readable page frame for top-level feature screens.
class AppPage extends StatelessWidget {
  const AppPage({
    required this.child,
    this.maxWidth = 640,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.x6),
    this.alignment = Alignment.topCenter,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
