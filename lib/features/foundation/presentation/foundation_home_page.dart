import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_preferences.dart';
import '../../../core/design_system/app_theme.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_page.dart';
import '../../../core/design_system/components/section_header.dart';
import '../../../core/localization/app_localizations.dart';

class FoundationHomePage extends ConsumerWidget {
  const FoundationHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final preferences = ref.watch(appPreferencesProvider);
    final notifier = ref.read(appPreferencesProvider.notifier);
    final theme = Theme.of(context);
    final isArabic = strings.isArabic;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appName, style: theme.textTheme.titleMedium),
        actions: [
          IconButton(
            tooltip: strings.language,
            onPressed: () => notifier.setLocale(
              isArabic ? const Locale('en') : const Locale('ar'),
            ),
            icon: const Icon(Icons.language_rounded),
          ),
          const SizedBox(width: AppSpacing.x2),
        ],
      ),
      body: AppPage(
        child: ListView(
          padding: const EdgeInsets.only(
            top: AppSpacing.x4,
            bottom: AppSpacing.x12,
          ),
          children: [
                Text(
                  strings.eyebrow,
                  style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.x4),
                Text(strings.headline, style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.x3),
                Text(
                  strings.intro,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    height: 1.65,
                  ),
                ),
                const SizedBox(height: AppSpacing.x8),
                SectionHeader(title: strings.principles),
                const SizedBox(height: AppSpacing.x4),
                _PrincipleCard(
                  icon: Icons.space_dashboard_outlined,
                  title: strings.principleDesign,
                  description: strings.principleDesignDetail,
                ),
                const SizedBox(height: AppSpacing.x3),
                _PrincipleCard(
                  icon: Icons.account_tree_outlined,
                  title: strings.principleArchitecture,
                  description: strings.principleArchitectureDetail,
                ),
                const SizedBox(height: AppSpacing.x3),
                _PrincipleCard(
                  icon: Icons.accessibility_new_rounded,
                  title: strings.principleAccessible,
                  description: strings.principleAccessibleDetail,
                ),
                const SizedBox(height: AppSpacing.x8),
                Text(strings.appearance, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.x3),
                SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text(strings.system),
                      icon: const Icon(Icons.brightness_auto_rounded),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text(strings.light),
                      icon: const Icon(Icons.light_mode_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text(strings.dark),
                      icon: const Icon(Icons.dark_mode_outlined),
                    ),
                  ],
                  selected: {preferences.themeMode},
                  onSelectionChanged: (selection) =>
                      notifier.setThemeMode(selection.first),
                ),
                const SizedBox(height: AppSpacing.x8),
                Center(
                  child: Text(
                    strings.footer,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
          ],
      ),
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  const _PrincipleCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.medium),
              ),
              child: Icon(icon, size: 22),
            ),
            const SizedBox(width: AppSpacing.x4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.x1),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
