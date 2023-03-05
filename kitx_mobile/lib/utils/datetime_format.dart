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

String _threeDigits(int n) {
  if (n >= 100) return '$n';
  if (n >= 10) return '0$n';
  return '00$n';
}

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}

/// 将一个 DateTime 转化成 Iso8601 标准格式
///
/// 以符合 KitX 要求
///
/// e.g. `2022-10-14T18:09:02.367214+08:00`
/// Update: 2023-1-7 由于改用 build_value 生成代码, 此方法弃用
/*
String datetimeToIso8601(DateTime time) {
  time = time.toLocal();
  String y =
  (time.year >= -9999 && time.year <= 9999) ? _fourDigits(time.year) : _sixDigits(time.year);
  String m = _twoDigits(time.month);
  String d = _twoDigits(time.day);
  String h = _twoDigits(time.hour);
  String min = _twoDigits(time.minute);
  String sec = _twoDigits(time.second);
  String ms = _threeDigits(time.millisecond);
  String us = time.microsecond == 0 ? '' : _threeDigits(time.microsecond);
  var offset = time.timeZoneOffset;
  return '$y-$m-${d}T$h:$min:$sec.$ms$us${offset.isNegative ? '-' : '+'}${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes - offset.inHours * 60).toString().padLeft(2, '0')}';
}
*/

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
