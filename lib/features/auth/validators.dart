import 'package:get/get.dart';

final RegExp _emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

String? isValidEmail(String? email) {
  if (email!.trim().isEmpty) return "email_hint".tr;
  return _emailRegExp.hasMatch(email.trim()) ? null : "invalid_email".tr;
}

String? isValidName(String? value) {
  return value!.isNotEmpty ? null : "name_hint".tr;
}

String? isValidCode(String? value) {
  return value!.isNotEmpty ? null : "empty_code".tr;
}

String? isValidPhone(String? phone) {
  //Todo change the length validation later
  return phone!.isNotEmpty ? null : "phone_hint".tr;
}

String? confirmPassword(String password, String? confirmedPassword) {
  if (confirmedPassword!.isEmpty) return "password_hint".tr;
  return password == confirmedPassword ? null : "confirm_not_match".tr;
}

String? isValidPassword(String? password) {
  if (password!.isEmpty) return "password_hint".tr;
  return password.length > 8 ? null : "short_password".tr;
}
