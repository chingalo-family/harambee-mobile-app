class FormatUtils {
  /// Formats a number with thousands separators
  /// Example: 150000 -> "150,000"
  static String formatWithThousandsSeparator(double value) {
    final intValue = value.toInt();
    final str = intValue.toString();
    final buffer = StringBuffer();
    
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    
    return buffer.toString();
  }

  /// Formats a string number with thousands separators
  /// Example: "150000" -> "150,000"
  static String formatStringWithThousandsSeparator(String value) {
    if (value.isEmpty) return '0';
    
    // Build formatted string by reversing, adding commas, then reversing again
    final reversed = value.split('').reversed.toList();
    final buffer = StringBuffer();
    
    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(reversed[i]);
    }
    
    return buffer.toString().split('').reversed.join('');
  }
}
