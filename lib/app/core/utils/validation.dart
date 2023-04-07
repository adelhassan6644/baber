import 'package:baber/navigation/custom_navigation.dart';
import '../../../domain/localization/language_constant.dart';

class Validations {

  static String? name(String? value) {
    if (value!.isEmpty) {
      return getTranslated("please_enter_your_name", CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }


  static String? phone(String? value) {
    if (value!.isEmpty) {
      return getTranslated ("required", CustomNavigator.navigatorState.currentContext!);
    } else if (value.length < 8) {
      return  getTranslated ("please_enter_valid_number",CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }


  static String? code(String? value) {
    if (value!.isEmpty||value.length < 4) {
      return getTranslated ("please_enter_valid_code",CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }


  static String? city(Object? value) {
    if (value!.toString().isEmpty) {
      return getTranslated ("please_choose_city",CustomNavigator.navigatorState.currentContext!);
    } else {
      return null;
    }
  }


}
