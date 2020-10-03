class Validators {
  static const Pattern numberPattern = r"^[0-9]*$";
  static const Pattern emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
  static const Pattern phonePattern = r"^[+][0-9]{1,}$";
  static const Pattern passwordPattern = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$";
  
  static RegExp numberRegex = new RegExp(r"^[0-9]*$");
  static RegExp emailRegex = new RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static RegExp phoneRegex = new RegExp(r"^[+][0-9]{1,}$");
  static RegExp passwordRegex = new RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

  static bool validString(String value, {int maxLength = 250})  => value != null && value.trim().isNotEmpty && value.trim().length <= maxLength;

  static bool validNumber(String value)                         => validString(value) && numberRegex.hasMatch(value);

  static bool validEmail(String value)                          => validString(value) && emailRegex.hasMatch(value);

  static bool validMobileNumber(String value)                   => validString(value) && phoneRegex.hasMatch(value);

  static bool validPassword(String value)                       => validString(value) && passwordRegex.hasMatch(value);
}