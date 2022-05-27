import 'package:flutter/cupertino.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'dart:core';

class DateChangedNotification extends Notification {
  late DateTime newDate;
  DateChangedNotification(this.newDate) : super();
}

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rate_saints',
  minDays: 3,
  minLaunches: 5,
  remindDays: 5,
  remindLaunches: 5,
);
