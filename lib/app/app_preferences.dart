import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) => null);

@immutable
class AppPreferences {
  const AppPreferences({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
  });

  final ThemeMode themeMode;
  final Locale locale;

  AppPreferences copyWith({ThemeMode? themeMode, Locale? locale}) {
    return AppPreferences(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  static AppPreferences fromStorage(SharedPreferences? storage) {
    final storedTheme = storage?.getString(_themeModeKey);
    final storedLocale = storage?.getString(_localeKey);

    return AppPreferences(
      themeMode: ThemeMode.values.firstWhere(
        (mode) => mode.name == storedTheme,
        orElse: () => ThemeMode.system,
      ),
      locale: switch (storedLocale) {
        'ar' => const Locale('ar'),
        _ => const Locale('en'),
      },
    );
  }
}

const _themeModeKey = 'preferences.theme_mode';
const _localeKey = 'preferences.locale';

class AppPreferencesNotifier extends Notifier<AppPreferences> {
  @override
  AppPreferences build() {
    return AppPreferences.fromStorage(ref.watch(sharedPreferencesProvider));
  }

  void setThemeMode(ThemeMode value) {
    state = state.copyWith(themeMode: value);
    final storage = ref.read(sharedPreferencesProvider);
    if (storage != null) {
      unawaited(storage.setString(_themeModeKey, value.name));
    }
  }

  void setLocale(Locale value) {
    final locale = value.languageCode == 'ar'
        ? const Locale('ar')
        : const Locale('en');
    state = state.copyWith(locale: locale);
    final storage = ref.read(sharedPreferencesProvider);
    if (storage != null) {
      unawaited(storage.setString(_localeKey, locale.languageCode));
    }
  }
}

final appPreferencesProvider =
    NotifierProvider<AppPreferencesNotifier, AppPreferences>(
      AppPreferencesNotifier.new,
    );
