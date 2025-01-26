///
/// Karee Internationalization.
///
/// Karee provides this library as a simplest way to work with
/// internationalization. This lib gives you translation support trough the
/// string extension defined and named [StringTranslator] by adding two methods
/// [StringTranslator.translate] and [StringTranslator.translateWithParams].
///
/// To define you translation dictionary, get open file in
/// {PROJECT_DIR@/resources/i18n/locale.json}.
///
/// Karee Internationalization also provides a simplest way to change language in
/// your application. You need to call [KareeInternationalization.changeLanguage]
/// with Locale that matches with your dictionary files.
///
/// eg:
/// ```dart
///
/// void updateUserLanguage(Locale locale){
///
///   // Applying change for future connexion
///
///   userService.changePreferedLanguage(locale);
///
///   //
///   // Applying change for in all the application.
///   // Precondition is that newLang is supportedLocal in your KareeMaterialApp
///
///   KareeInternationalization.changeLanguage(newLang);
///
/// }
/// ```
///
library karee.internationalization;

import 'src/utils/app_localization.dart';
export 'src/utils/app_language.dart';
export 'src/utils/app_localization.dart';

///
/// Extension that applies text translation in karee.
///
/// This extension adds two methods for translation.
///
extension StringTranslator on String {
  ///
  /// Method that considers a string as a key from i18n and return the
  /// translation (value associated in your i18n to this key).
  ///
  String translate() {
    return KareeInternationalization.appLocalization.value.translation?[this]
            ?.toString() ??
        this;
  }

  ///
  /// Method that considers a string as a key from i18n and replace all the
  /// translation parameters [params] with their values and return the
  /// translated string.
  ///
  String translateWithParams(Map<String, String> params) {
    String self = KareeInternationalization
            .appLocalization.value.translation?[this]
            ?.toString() ??
        this;
    for (var entryParam in params.entries) {
      self = self.replaceAll('\${${entryParam.key}}', entryParam.value);
    }

    return self;
  }
}
