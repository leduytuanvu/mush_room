class AppValidation {
  static String checkEmail(String value) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
    if (value.isEmpty) {
      return '* Email is required';
    } else if (!emailRegex.hasMatch(value)) {
      return '* Invalid email';
    } else {
      return '';
    }
  }

  static String checkCode(String value) {
    if (value.isEmpty) {
      return '* Verification code is required';
    } else {
      return '';
    }
  }

  static String checkUsername(String value) {
    if (value.isEmpty) {
      return '* Username is required';
    } else if (value.length < 8) {
      return '* Minimum username is 8 character';
    } else {
      return '';
    }
  }

  static String checkPhone(String value) {
    if (value.isNotEmpty) {
      if (value.length < 10 || value.length > 11) {
        return '* Invalid phone number';
      }
      return '';
    } else {
      return '* Phone is required';
    }
  }

  static String checkPassword(String value) {
    if (value.isEmpty) {
      return '* Password is required';
    } else if (value.length < 8) {
      return '* Minimum password is 8 characters';
    } else {
      return '';
    }
  }

  static String checkConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return '* Password is required';
    } else if (confirmPassword.length < 8) {
      return '* Minimum password is 8 characters';
    } else if (password != confirmPassword) {
      return "* Confirm password must match password";
    } else {
      return '';
    }
  }
}
