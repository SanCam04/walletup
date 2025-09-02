/// Transaction domain policies and business rules
class TransactionPolicy {
  /// Maximum length for transaction descriptions
  static const int maxDescriptionLength = 200;

  /// Minimum transaction amount
  static const double minAmount = 0.01;

  /// Maximum transaction amount
  static const double maxAmount = 999999.99;
}
