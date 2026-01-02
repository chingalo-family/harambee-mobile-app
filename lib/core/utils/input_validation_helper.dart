class InputValidationHelper {
  /// Checks if zero buttons (0, 00, 000) should be enabled
  /// Zero buttons are only enabled when there's a valid positive integer input
  static bool shouldEnableZeroButtons(String currentInput) {
    if (currentInput.isEmpty) return false;
    
    final parsedValue = int.tryParse(currentInput);
    if (parsedValue == null) return false;
    
    return parsedValue > 0;
  }

  /// Validates if the input is a valid number
  static bool isValidNumber(String input) {
    if (input.isEmpty) return false;
    return int.tryParse(input) != null;
  }

  /// Checks if adding more digits would exceed the maximum length
  static bool canAddMoreDigits(String currentInput, {int maxLength = 10}) {
    return currentInput.length < maxLength;
  }
}
