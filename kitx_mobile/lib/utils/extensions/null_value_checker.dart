/// [String?] Extensions
extension StringNullValueCheckerExtensions on String? {
  /// Check if [String] is null or empty
  String? ifNull(String really) {
    return this == null ? really : this;
  }
}
