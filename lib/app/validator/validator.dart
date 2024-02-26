class Validator{


   static String? isEmailValid({required String? value}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email";
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Please enter valid email";
    } else {
      return null;
    }
  }

   static String? isNameValid({required String? value}) {
    if (value == null || value.trim().toString().isEmpty) {
      return "Please enter name";
    } else if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
      return "Please enter valid name";
    } else if (value.trim().length > 20) {
      return "Name length less than twenty";
    } else {
      return null;
    }
  }

   static String? isNumberValid({required String? value}) {
    if (value == null || value.trim().toString().isEmpty) {
      return "Please enter number";
    } else if (value.trim().length < 10 || value.trim().length > 12) {
      return "Please enter valid number";
    } else {
      return null;
    }
  }

   static String? isValid({required String? value,required String title})
  {
    if (value == null || value.trim().toString().isEmpty)
    {
      return "Please enter $title";
    } else {
        return null;
      }
    }

}