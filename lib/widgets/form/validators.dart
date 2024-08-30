String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  // Regular expression for basic email validation
  final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }
  return null;
}

String? validateMobile(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mobile number cannot be empty';
  }
  // Regular expression for basic mobile number validation
  final mobileRegExp = RegExp(r'^[0-9]{10}$');
  if (!mobileRegExp.hasMatch(value)) {
    return 'Enter a valid mobile number';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one capital letter';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  }
  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }
  return null;
}
