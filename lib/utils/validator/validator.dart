class Validators {
  static String? _normalcheck(String val) {
    // ignore: unnecessary_null_comparison
    if (val == null) {
      return 'Please fill the field';
    }
    if (val.isEmpty) {
      return 'Please fill the field';
    }
    return null;
  }

  static String? nameValidator(String? val) => _normalcheck(val!);

  static String? emailValidator(String? email) {
    if (_normalcheck(email!) != null) {
      return 'Please enter your Email Address';
    }

    bool isReExpresionResult = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!isReExpresionResult) {
      return 'Enter correct Email Address';
    }
    return null;
  }

  static String? phoneNumberCheck(String? val) {
    if (_normalcheck(val!) != null) {
      return 'Please enter your mobile number';
    }
    if (double.tryParse(val) == null) {
      return 'Enter Correct Mobile Number';
    }

    if (val.length < 13) {
      return 'Enter Correct Mobile Number';
    }

    return null;
  }

  static String? passwordValidator(String? val) {
    if (_normalcheck(val!) != null) {
      return 'Please fill the field';
    }

    if (val.length <= 5) {
      return 'Password must be greater than 6 length';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? val, String? oldPass) {
    if (_normalcheck(val!) != null) {
      return 'Please fill the field';
    }
    if (val.length <= 5) {
      return 'Password must be greater than 6 length';
    }
    if (val != oldPass) {
      return "Password mismatch";
    }
    return null;
  }
}
