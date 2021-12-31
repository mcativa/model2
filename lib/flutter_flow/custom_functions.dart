import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String getModelMeasuresStr(UsersRecord userRecord) {
  // concatenate bust waist hips
  final modelMeasureBust = userRecord.modelMeasureBust;
  final modelMeasureWaist = userRecord.modelMeasureWaist;
  final modelMeasureHips = userRecord.modelMeasureHips;
  return 'B: $modelMeasureBust W: $modelMeasureWaist H: $modelMeasureHips';
}

double validateRangeDbl(
  double min,
  double max,
  double def,
  double value,
) {
  // check value is between min and max, if not, return default value
  return max >= value && value >= min ? value : def;
}

String cm2ftStr(double cm) {
  // centimeters to feet and inches
  double cms = 0;
  if (cm == null) {
    return '0\' 0"';
  }
  double feet = cm / 30.48;
  double inches = feet % 1;
  feet = feet - inches;

  inches = inches * 12;
  return '${feet.toStringAsFixed(0)}`$inches`';
}
