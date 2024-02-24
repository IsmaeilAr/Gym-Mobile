import 'package:flutter/material.dart';
import 'package:gym/utils/helpers/cache.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _appLocale = const Locale("en", "");

  // late Locale _appLocale;
  SharedPreferencesService prefsService = SharedPreferencesService.instance;

  LanguageProvider() {
    loadLocale();
  }

  Future<void> loadLocale() async {
    String? languageCode = prefsService.getValue('language_code') as String?;
    String? countryCode = prefsService.getValue('country_code') as String?;
    if (languageCode != null && countryCode != null) {
      _appLocale = Locale(languageCode, countryCode);
    } else {
      _appLocale = WidgetsBinding.instance.platformDispatcher.locale;
    }
  }

  changeLanguage(Locale locale) async {
    await prefsService.setValue('language_code', locale.languageCode);
    await prefsService.setValue('country_code', locale.countryCode ?? "");
    _appLocale = locale;
    notifyListeners();
  }

  Locale get appLocale => _appLocale;
}
