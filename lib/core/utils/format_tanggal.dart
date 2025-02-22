import 'package:intl/intl.dart';

String formatTanggal(String tglIso) {
  DateTime dateTime = DateTime.parse(tglIso);
  // String timeZoneName = dateTime.timeZoneName;
  // Duration timeZoneOffset = dateTime.timeZoneOffset;
  DateFormat dateFormat = DateFormat('d MMMM yyyy HH:mm');
  String formattedDate = dateFormat.format(dateTime);
  return '$formattedDate ${_getTimeZoneName(DateTime.now())}';
}

String _getTimeZoneName(DateTime dateTime) {
  Duration offset = dateTime.timeZoneOffset;
  if (offset == Duration(hours: 7)) {
    return 'WIB'; // (UTC+7)
  } else if (offset == Duration(hours: 8)) {
    return 'WITA'; // (UTC+8)
  } else if (offset == Duration(hours: 9)) {
    return 'WIT'; // (UTC+9)
  } else {
    return dateTime.timeZoneName; // Default name
  }
}
