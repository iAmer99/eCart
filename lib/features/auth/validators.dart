import 'package:flutter/material.dart';

final RegExp _emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

String? isValidEmail(String? email) {
  if (email!.trim().isEmpty) return "Email is empty";
  return _emailRegExp.hasMatch(email.trim()) ? null : "Invalid email";
}

String? isValidName(String? value) {
  return value!.isNotEmpty ? null : "Name is empty";
}

String? isValidCode(String? value) {
  return value!.isNotEmpty ? null : "Code is empty";
}

String? isValidPhone(String? phone) {
  //Todo change the length validation later
  return phone!.isNotEmpty ? null : "Mobile is empty";
}

String? confirmPassword(String password, String? confirmedPassword) {
  if (confirmedPassword!.isEmpty) return "Password is empty";
  return password == confirmedPassword ? null : "Passwords must match";
}

String? isValidPassword(String? password) {
  if (password!.isEmpty) return "Password is empty";
  return password.length > 8 ? null : "Password is too short";
}
