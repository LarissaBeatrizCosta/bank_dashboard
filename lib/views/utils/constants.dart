
import 'package:intl/intl.dart';

///Token da filial
class Constants {
  ///Token
  static const userKey = 'user_key';

  ///Nome do usuario
  static const String userName = 'user_name';
}

/// Try to parse the provided string as date with the provided format template.
/// Returns null if the string can't be parsed as a date
DateTime? tryParseDate(String template, String? date) {
  if (date == null || date.isEmpty) {
    return null;
  }

  try {
    return DateFormat(template).parseStrict(date);
  } on FormatException catch (e, stack) {
    return null;
  }
}

/// Try to format the provided date as string with the provided format template.
/// Returns null if the date can't be parsed as a string
String? tryFormatDate(String template, DateTime? date) {
  if (date == null) {
    return null;
  }

  try {
    return DateFormat(template).format(date);
  } on FormatException catch (e, stack) {
    return null;
  }
}

