import 'package:appmosphere/core/localization/localization_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Helpers {
  static String formatDate(int timestamp, context) {
    final localization = Provider.of<LocalizationProvider>(context, listen: false);

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return DateFormat('EEEE, MMM d', localization.languageCode).format(date);
  }

  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(date); // 15:00
  }

  static int hourDifference(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateTime.now().difference(date).inHours;
  }
}
