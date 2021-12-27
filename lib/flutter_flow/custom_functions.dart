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
