/// Application constants
class AppConstants {
  static const String appName = 'WalletUp';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'walletup.db';
  static const int databaseVersion = 1;

  // Storage keys
  static const String walletsStorageKey = 'wallets';
  static const String transactionsStorageKey = 'transactions';

  // Validation
  static const int maxWalletNameLength = 50;
  static const int maxTransactionDescriptionLength = 200;
  static const double minTransactionAmount = 0.01;
  static const double maxTransactionAmount = 999999.99;
}
