// ignore_for_file: non_constant_identifier_names

/// allowable overflowSize
var overflowSizeUnits = 102 * 2;

/// Convert bytes length to double
double convert2double(int bytesLength) {
  var KB = bytesLength / 1024.0;
  var MB = KB / 1024.0;
  var GB = MB / 1024.0;
  var TB = GB / 1024.0;

  if (KB >= 0 && KB < 1024 + overflowSizeUnits) {
    return KB;
  } else if (MB < 1024 + overflowSizeUnits) {
    return MB;
  } else if (GB < 1024 + overflowSizeUnits) {
    return GB;
  } else {
    return TB;
  }
}

/// Convert bytes length to string
String convert2string(int bytesLength) {
  var KB = bytesLength / 1024.0;
  var MB = KB / 1024.0;
  var GB = MB / 1024.0;
  var TB = GB / 1024.0;

  if (KB >= 0 && KB < 1024 + overflowSizeUnits) {
    return '${KB.toStringAsFixed(2)} KB';
  } else if (MB < 1024 + overflowSizeUnits) {
    return '${MB.toStringAsFixed(2)} MB';
  } else if (GB < 1024 + overflowSizeUnits) {
    return '${GB.toStringAsFixed(2)} GB';
  } else {
    return '${TB.toStringAsFixed(2)} TB';
  }
}
