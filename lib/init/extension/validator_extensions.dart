extension ValidatorX on String {
  String? isValidEmail() {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(this)) {
      return null;
    }
    return "Geçerli bir email adresi giriniz!";
  }

  // String? isValidPassword( ) {
  //   if (length < 6 ) {
  //     return "Şifreniz en az 6 karakter olmalıdır!";
  //   }
  //   return null;
  // }

  String? isSamePassword(String password2) {
    if (this != password2) {
      return "Şifreler aynı olmalıdır!";
    }
    return null;
  }

  String? get isValEmpty {
    if (isEmpty) {
      return "Bu alan boş bırakılamaz!";
    }
    return null;
  }
}
