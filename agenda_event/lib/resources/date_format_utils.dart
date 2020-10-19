import 'package:intl/intl.dart';

const String _locate = 'pt_BR';

String formatHm(DateTime date) =>
    isNull(date) ? null : DateFormat.Hm(_locate).format(date);

String formatdMMMHHmm(DateTime date) =>
    isNull(date) ? null : DateFormat('dd/MM/yyyy HH:mm', _locate).format(date);

DateTime toUtf3(String date) => (date ?? '').isEmpty
    ? null
    : DateTime.parse(date)?.subtract(const Duration(hours: 3));

bool isNull(DateTime date) => date == null;

String formartHours(DateTime date) =>
    isNull(date) ? null : DateFormat.H(_locate).format(date);

String formartDate(DateTime date) =>
    isNull(date) ? null : DateFormat('dd/MM/yyyy', _locate).format(date);

String formartDateDayAndMonth(DateTime date) =>
    isNull(date) ? null : DateFormat('dd/MM', _locate).format(date);

String formartDateAbrev(DateTime date) =>
    isNull(date) ? null : DateFormat('MMM d', _locate).format(date);

String month(DateTime date) =>
    date == null ? '' : DateFormat('MMMM', _locate).format(date);

String year(DateTime date) =>
    date == null ? '' : DateFormat('yyyy').format(date);

String formartDateCompleteForm(DateTime date) => isNull(date)
    ? null
    : '${DateFormat('dd', _locate).format(date)} de ${DateFormat('MMMM, EEEE ', _locate).format(date)}';

String formartDay(DateTime date) =>
    isNull(date) ? null : ' ${DateFormat('EEEE', _locate).format(date)}';

String formartBetweenHours(DateTime start, DateTime end) {
  if (isNull(start)) {
    return '';
  }

  if (!isNull(start) && isNull(end)) {
    return '${formartHours(start)}h';
  }

  return '${formartHours(start)}h as ${formartHours(end)}h';
}

String formartBetweenDate(DateTime start, DateTime end) {
  if (isNull(start)) {
    return '';
  }
  if (!isNull(start) && isNull(end)) {
    return '${formartDate(start)}';
  }
  return '${formartDate(start)} a ${formartDate(end)}';
}

String formartBetweenDateAbrev(DateTime start, DateTime end) {
  if (isNull(start)) {
    return '';
  }
  if ((!isNull(start) && isNull(end)) ||
      (formartDateAbrev(end) == formartDateAbrev(start))) {
    return '${formartDateAbrev(start)}';
  }
  return '${formartDateAbrev(start)} a ${formartDateAbrev(end)}';
}

DateTime fromJsonDateTime(String date) =>
    (date ?? '').trim().isEmpty ? null : DateFormat.yMd().parse(date);
String toJsonDateTime(DateTime date) =>
    date == null ? null : DateFormat.yMd().format(date);

String dateToDateSql(DateTime date) =>
    date == null ? null : DateFormat('yyyy-MM-dd').format(date);

final DateFormat _timeFormatter = DateFormat('HH:mm:ss');

DateTime timeFromJson(String date) =>
    date == null ? null : _timeFormatter.parse(date);
String timetoJson(DateTime date) =>
    date == null ? null : _timeFormatter.format(date);
