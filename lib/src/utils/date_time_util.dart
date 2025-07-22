import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static String getTimeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  static String getRelativeTime(String dateString) {
    DateTime? date = DateTime.tryParse(dateString);
    if (date == null) return "Invalid date";

    DateTime now = DateTime.now();
    Duration diff = now.difference(date);

    if (diff.inDays == 0) {
      return "Today";
    } else if (diff.inDays == 1) {
      return "Yesterday";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 30) {
      return "${(diff.inDays / 7).floor()} weeks ago";
    } else if (diff.inDays < 365) {
      return "${(diff.inDays / 30).floor()} months ago";
    } else {
      return "${(diff.inDays / 365).floor()} years ago";
    }
  }

  static String getChatListTime(String dateString) {
    DateTime? date = DateTime.tryParse(dateString);
    if (date == null) return "Invalid date";

    DateTime now = DateTime.now();
    Duration diff = now.difference(date);

    // Format time as 10:00 AM
    String formattedTime =
        "${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}";

    if (diff.inDays == 0) {
      return "Today, $formattedTime";
    } else if (diff.inDays == 1) {
      return "Yesterday, $formattedTime";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago, $formattedTime";
    } else if (diff.inDays < 30) {
      return "${(diff.inDays / 7).floor()} weeks ago, $formattedTime";
    } else if (diff.inDays < 365) {
      return "${(diff.inDays / 30).floor()} months ago, $formattedTime";
    } else {
      return "${(diff.inDays / 365).floor()} years ago, $formattedTime";
    }
  }

  static String getChatDayDateFormatted(String formattedDate) {
    DateTime now = DateTime.now();
    DateTime inputDate = DateFormat('dd MMM yyyy').parse(formattedDate);

    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (inputDate == today) {
      return "Today";
    } else if (inputDate == yesterday) {
      return "Yesterday";
    } else {
      return formattedDate;
    }
  }

  static String chatDetailFormatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static DateTime? convertToLocalDateTime(String utcString) {
    final utcDateTime = DateTime.tryParse(utcString);
    return utcDateTime?.toLocal();
  }

  static String? convertToLocalDateTimeString(String utcString) {
    final utcDateTime = DateTime.tryParse(utcString);
    return (utcDateTime?.toLocal() ?? '').toString();
  }
}
