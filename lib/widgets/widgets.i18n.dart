import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  static var t = Translations("en_us") +
      {
        "en_us": "Filter problems",
        "fi_fi": "Suodata ratoja",
      } +
      { "en_us": "Archive",
        "fi_fi": "Arkisto", } +
      { "en_us": "Circuits",
        "fi_fi": "Ympyrät", } +

      { "en_us": "Groups",
        "fi_fi": "Ryhmät", } +
      {
        "en_us": "Profile",
        "fi_fi": "Profiili",
      } +
      { "en_us": "Home",
        "fi_fi": "Koti", } +
      { "en_us": "Competitions",
        "fi_fi": "Kisahommat", } +
      { "en_us": "QR-Scanner",
        "fi_fi": "QR-Scanneri", } +
      {
        "en_us": "Change Language",
        "pt_br": "Mude Idioma",
      } +
      {
        "en_us": "You clicked the button %d times:"
            .zero("You haven't clicked the button:")
            .one("You clicked it once:")
            .two("You clicked a couple times:")
            .many("You clicked %d times:")
            .times(12, "You clicked a dozen times:"),
        "pt_br": "Você clicou o botão %d vezes:"
            .zero("Você não clicou no botão:")
            .one("Você clicou uma única vez:")
            .two("Você clicou um par de vezes:")
            .many("Você clicou %d vezes:")
            .times(12, "Você clicou uma dúzia de vezes:"),
      };

  String get i18n => localize(this, t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, t);

  String version(Object modifier) => localizeVersion(modifier, this, t);

  Map<String, String> allVersions() => localizeAllVersions(this, t);
}