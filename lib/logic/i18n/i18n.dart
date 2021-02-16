import 'dart:io' as ui;

import 'package:boucherie_conakry/logic/cache/prefs.dart';
import 'values.dart';

abstract class I18N {
  static String _locale = Prefs.instance.getString('locale') ??
          ui.Platform.localeName.startsWith('fr')
      ? 'fr'
      : 'en';

  static String get locale => _locale;

  static void setLocale(String newLocale) {
    _locale = newLocale;
    Prefs.instance.setString('locale', newLocale);
  }

  static String text(String text) => Values.instance[locale][text];
}