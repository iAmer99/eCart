import 'package:ecart/features/shared/localization/ar.dart';
import 'package:ecart/features/shared/localization/en.dart';
import 'package:get/get.dart';

class Texts extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' : englishTranslations,
    'ar_EG' : arabicTranslations,
  };

}