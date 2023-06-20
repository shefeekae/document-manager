class Validation {
  //Validation for Title field
  validateTitle(String? value) {
    if (value!.isEmpty) {
      return "Please enter a title";
    }
    return null;
  }

  //Validation for Description field
  validateDescription(String? value) {
    if (value!.isEmpty) {
      return "Please enter a description";
    }
    return null;
  }
}
