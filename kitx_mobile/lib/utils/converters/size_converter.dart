/// Allowable overflowSize
var overflowSizeUnits = 102 * 2;

/// Convert bytes length to double
double convert2double(int bytesLength) {
  var sizeInKB = bytesLength / 1024.0;
  var sizeInMB = sizeInKB / 1024.0;
  var sizeInGB = sizeInMB / 1024.0;
  var sizeInTB = sizeInGB / 1024.0;

  if (sizeInKB >= 0 && sizeInKB < 1024 + overflowSizeUnits) {
    return sizeInKB;
  } else if (sizeInMB < 1024 + overflowSizeUnits) {
    return sizeInMB;
  } else if (sizeInGB < 1024 + overflowSizeUnits) {
    return sizeInGB;
  } else {
    return sizeInTB;
  }
}

/// Convert bytes length to string
String convert2string(int bytesLength) {
  var sizeInKB = bytesLength / 1024.0;
  var sizeInMB = sizeInKB / 1024.0;
  var sizeInGB = sizeInMB / 1024.0;
  var sizeInTB = sizeInGB / 1024.0;

  if (sizeInKB >= 0 && sizeInKB < 1024 + overflowSizeUnits) {
    return '${sizeInKB.toStringAsFixed(2)} KB';
  } else if (sizeInMB < 1024 + overflowSizeUnits) {
    return '${sizeInMB.toStringAsFixed(2)} MB';
  } else if (sizeInGB < 1024 + overflowSizeUnits) {
    return '${sizeInGB.toStringAsFixed(2)} GB';
  } else {
    return '${sizeInTB.toStringAsFixed(2)} TB';
  }
}
