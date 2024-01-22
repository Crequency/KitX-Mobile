String _fourDigits(int n) {
  var absN = n.abs();
  var sign = n < 0 ? '-' : '';
  if (absN >= 1000) return '$n';
  if (absN >= 100) return '${sign}0$absN';
  if (absN >= 10) return '${sign}00$absN';
  return '${sign}000$absN';
}

String _sixDigits(int n) {
  assert(n < -9999 || n > 9999);
  var absN = n.abs();
  var sign = n < 0 ? '-' : '+';
  if (absN >= 100000) return '$sign$absN';
  return '${sign}0$absN';
}

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

/// Format [DateTime] to [String]
String datetimeToShortString(DateTime time) {
  time = time.toLocal();
  var y = (time.year >= -9999 && time.year <= 9999) ? _fourDigits(time.year) : _sixDigits(time.year);
  var m = _twoDigits(time.month);
  var d = _twoDigits(time.day);
  var h = _twoDigits(time.hour);
  var min = _twoDigits(time.minute);
  var sec = _twoDigits(time.second);
  return '$y-$m-$d $h:$min:$sec';
}
