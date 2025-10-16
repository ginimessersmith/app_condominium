class Helpers{
  static String formattedText(String formattedTextTow) {
    try {
      final doubleValue = double.parse(formattedTextTow);
      return formattedTextTow = doubleValue.toStringAsFixed(2);
    } catch (e) {
      return formattedTextTow = formattedTextTow;
    }
  }
}