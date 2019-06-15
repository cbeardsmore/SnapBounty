class Utils {
  static String capitalize(String x) => x[0].toUpperCase() + x.substring(1);
  static String toPercent(double x) => (x * 100).toStringAsFixed(0) + '%';
}