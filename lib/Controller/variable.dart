import 'package:flutter/material.dart';

class RegisterVariable {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController repeatPasswordController =
      TextEditingController();
}

class LoginVariable {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
}

class ForgotPasswordVariable {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController newPasswordController = TextEditingController();
  static TextEditingController newConfirmPasswordController =
      TextEditingController();
}

class AddContactVariable {
  static TextEditingController firstnameController = TextEditingController();
  static TextEditingController lastnameController = TextEditingController();
  static TextEditingController numberController = TextEditingController();
}
