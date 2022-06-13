mixin InputValidationMixin {
  bool? isPasswordValid(String? password) {
    return password!.length >= 8;
  }

  bool doPasswordsMatch(String pass, String confirmation){
    return identical(pass, confirmation);
  }

  bool isEmailValid(String email) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());

    return regex.hasMatch(email);
  }

  bool isTextValid(String text){
    return text.length >= 3;
  }

  bool isPhoneValid(String phone){
    return phone.length >= 9;
  }
}