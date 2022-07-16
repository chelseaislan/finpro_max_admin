// @dart=2.9
class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9+_.-]+@mm.id+$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
