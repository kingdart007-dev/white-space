import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  static AppLocalizations of(BuildContext context) {
    final result = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(result != null, 'AppLocalizations was not found in the widget tree.');
    return result!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isArabic => locale.languageCode == 'ar';

  String get appName => isArabic ? 'وايت سبيس' : 'White Space';
  String get eyebrow => isArabic ? 'أساس Flutter' : 'THE FLUTTER FOUNDATION';
  String get headline => isArabic ? 'مساحة للتفكير بوضوح.' : 'Room to think clearly.';
  String get intro => isArabic
      ? 'أساس هادئ ومتقن لبناء تطبيقات موبايل سهلة الاستخدام وقابلة للصيانة.'
      : 'A calm, considered starting point for mobile apps that feel clear and stay maintainable.';
  String get principles => isArabic ? 'المبادئ الأساسية' : 'The essentials';
  String get principleDesign => isArabic ? 'تصميم هادئ' : 'Considered design';
  String get principleDesignDetail => isArabic
      ? 'ألوان محايدة ومساحات مريحة وتسلسل بصري واضح.'
      : 'Neutral tones, generous space, and a clear visual hierarchy.';
  String get principleArchitecture => isArabic ? 'معمارية عملية' : 'Pragmatic architecture';
  String get principleArchitectureDetail => isArabic
      ? 'تقسيم حسب الميزة مع Riverpod و go_router.'
      : 'Feature-first structure with Riverpod and go_router.';
  String get principleAccessible => isArabic ? 'متاح للجميع' : 'Accessible by default';
  String get principleAccessibleDetail => isArabic
      ? 'دعم العربية والإنجليزية والثيمات المختلفة.'
      : 'Arabic and English, with flexible themes and layouts.';
  String get appearance => isArabic ? 'المظهر' : 'Appearance';
  String get system => isArabic ? 'حسب النظام' : 'System';
  String get light => isArabic ? 'فاتح' : 'Light';
  String get dark => isArabic ? 'داكن' : 'Dark';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get english => 'English';
  String get arabic => 'العربية';
  String get footer => isArabic
      ? 'نقطة بداية، وليست قيودًا على المنتج.'
      : 'A starting point, not a constraint on the product.';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any(
        (supported) => supported.languageCode == locale.languageCode,
      );

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
