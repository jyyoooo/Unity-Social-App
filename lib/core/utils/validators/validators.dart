const emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';

const usernameRegex = r'^[a-zA-Z0-9_]{3,20}$';

const amoutnRegex = r'^[0-9]+$';

String? maximumMembersValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Maximum members is required';
  }
  try {
    int parsedValue = int.parse(value);
    if (parsedValue <= 0) {
      return 'Enter a valid number';
    } else if (parsedValue > 500) {
      return 'Should be below 500';
    }
  } catch (e) {
    return 'Enter a valid number';
  }

  return null;
}

String? descriptionValidation(value) {
  if (value!.isEmpty) {
    return 'Description is required';
  } else if (value.toString().trim().isEmpty) {
    return 'Enter a valid description';
  } else if (value.split('').length < 24) {
    return 'Description is too short';
  }
  return null;
}

String? titlevalidation(value) {
  if (value!.isEmpty) {
    return 'Title is required';
  } else if (value.toString().trim().isEmpty) {
    return 'Enter a valid title';
  } else if (value.length < 8) {
    return 'Title is too short';
  }
  return null;
}

String? confirmPassValidation(value, comparator) {
  if (value!.isEmpty) {
    return 'Confirm password is required';
  } else if (comparator != value) {
    return 'Passwords dont match';
  }
  return null;
}

String? passwordValidation(value) {
  if (value!.isEmpty) {
    return 'Password is required';
  } else if (value.length < 8) {
    return 'Password is too short';
  }
  return null;
}

String? emailValidation(value) {
  if (value!.isEmpty) {
    return 'E-mail is required';
  } else if (!RegExp(emailRegex).hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? nameValidation(value) {
  if (value!.isEmpty) {
    return 'Name is required';
  } else if (value.length < 4) {
    return 'Name is too short';
  }
  return null;
}

String? amountValidator(value) {
  if (value!.isEmpty) {
    return 'Enter a donation amount';
  } else if (!RegExp(amoutnRegex).hasMatch(value)) {
    return 'Enter a valid amount';
  }
  return null;
}
