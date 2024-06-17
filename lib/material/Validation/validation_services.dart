class Valid {
  String? formvaild(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Something";
    }
    return null;
  }

  //This is Mobile number Validator
  String? mobilevalid(String? value) {
    if (value!.isEmpty) {
      return "Please Enter a Phone Number";
    } else if (value.length != 10) {
      return "Please Enter a Valid Phone Number";
    }
    return null;
  }

  String? ageValid(String? value) {
    if (value!.isEmpty) {
      return "Please Enter an Age";
    } else if (int.parse(value) < 16) {
      return "Age must be at least 16";
    }
    return null;
  }

  String? aadhaarValid(String? value) {
    if (value!.isEmpty) {
      return "Please enter your Aadhaar Number";
    } else if (int.parse(value) != 16) {
      return "It must contain 16 digit";
    }
    return null;
  }
}
