import 'package:supercharged/supercharged.dart';

class NameOfDay {
  final _value;
  const NameOfDay._internal(this._value);

  int toInt() => _value as int;
}

const pascha = NameOfDay._internal(100000);
const palmSunday = NameOfDay._internal(100001);
const ascension = NameOfDay._internal(100002);
const pentecost = NameOfDay._internal(100003);
const sundayOfForefathers = NameOfDay._internal(100004);
const sundayBeforeNativity = NameOfDay._internal(100005);

const saturdayOfFathers = NameOfDay._internal(100009);
const sunday1GreatLent = NameOfDay._internal(100006);
const sunday2GreatLent = NameOfDay._internal(11274);
const sunday3GreatLent = NameOfDay._internal(100007);
const sunday4GreatLent = NameOfDay._internal(4121);
const saturdayAkathist = NameOfDay._internal(100008);
const lazarusSaturday = NameOfDay._internal(100010);
const sunday5GreatLent = NameOfDay._internal(4141);

const theotokosIveron = NameOfDay._internal(2250);
const theotokosLiveGiving = NameOfDay._internal(100100);
const theotokosDubenskaya = NameOfDay._internal(100101);
const theotokosChelnskaya = NameOfDay._internal(100103);
const theotokosWall = NameOfDay._internal(100105);
const theotokosSevenArrows = NameOfDay._internal(100106);
const firstCouncil = NameOfDay._internal(100107);
const theotokosTabynsk = NameOfDay._internal(100108);
const newMartyrsOfRussia = NameOfDay._internal(100109);
const holyFathersSixCouncils = NameOfDay._internal(100110);
const allRussianSaints = NameOfDay._internal(100111);
const holyFathersSeventhCouncil = NameOfDay._internal(100112);
const synaxisFathersKievCaves = NameOfDay._internal(100113);

class ChurchCalendar {
  late int year;
  late Map<DateTime, List<NameOfDay>> feasts;
  late DateTime greatLentStart, P;
  late DateTime leapStart, leapEnd;
  late bool isLeapYear;

  static Map<int, ChurchCalendar> calendars = {};

  factory ChurchCalendar.fromDate(DateTime d) {
    var year = d.year;

    if (!ChurchCalendar.calendars.containsKey(year)) {
      ChurchCalendar.calendars[year] = ChurchCalendar(d);
    }

    return ChurchCalendar.calendars[year]!;
  }

  ChurchCalendar(DateTime d) {
    year = d.year;

    P = paschaDay(year);
    greatLentStart = P - 48.days;

    leapStart = DateTime(year, 2, 29);
    leapEnd = DateTime(year, 3, 13);
    isLeapYear = (year % 400) == 0 || ((year % 4 == 0) && (year % 100 != 0));

    initFeasts();
  }

  initFeasts() {
    feasts = {
      greatLentStart - 2.days: [saturdayOfFathers],
      greatLentStart + 6.days: [sunday1GreatLent],
      greatLentStart + 13.days: [sunday2GreatLent, synaxisFathersKievCaves],
      greatLentStart + 20.days: [sunday3GreatLent],
      greatLentStart + 27.days: [sunday4GreatLent],
      greatLentStart + 33.days: [saturdayAkathist],
      greatLentStart + 34.days: [sunday5GreatLent],
      greatLentStart + 40.days: [lazarusSaturday],
      P - 7.days: [palmSunday],
      P: [pascha],
      P + 2.days: [theotokosIveron],
      P + 39.days: [ascension],
      P + 49.days: [pentecost],
      P + 5.days: [theotokosLiveGiving],
      P + 24.days: [theotokosDubenskaya],
      P + 42.days: [theotokosChelnskaya, firstCouncil],
      P + 56.days: [theotokosWall, theotokosSevenArrows],
      P + 61.days: [theotokosTabynsk],
      P + 63.days: [allRussianSaints],
      nearestSunday(DateTime(year, 2, 7)): [newMartyrsOfRussia],
      nearestSunday(DateTime(year, 7, 29)): [holyFathersSixCouncils],
      nearestSunday(DateTime(year, 10, 24)): [holyFathersSeventhCouncil]
    };

    final nativity = DateTime(year, 1, 7);

    if (nativity.weekday != DateTime.sunday) {
      feasts[nearestSundayBefore(nativity)] = [sundayBeforeNativity];
    }

    final nativityNextYear = DateTime(year + 1, 1, 7);

    if (nativityNextYear.weekday == DateTime.sunday) {
      feasts[nearestSundayBefore(nativityNextYear)] = [sundayBeforeNativity];
    }

    feasts[nearestSundayBefore(nativityNextYear) - 7.days] = [sundayOfForefathers];
  }
}

extension ChurchCalendarFunc on ChurchCalendar {
  DateTime paschaDay(int year) {
    final a = (19 * (year % 19) + 15) % 30;
    final b = (2 * (year % 4) + 4 * (year % 7) + 6 * a + 6) % 7;

    return ((a + b > 10) ? DateTime(year, 4, a + b - 9) : DateTime(year, 3, 22 + a + b)) + 13.days;
  }

  DateTime nearestSundayBefore(DateTime d) => d - d.weekday.days;

  DateTime nearestSundayAfter(DateTime d) =>
      d.weekday == DateTime.sunday ? d + 7.days : d + (7 - d.weekday).days;

  DateTime nearestSunday(DateTime d) {
    switch (d.weekday) {
      case DateTime.sunday:
        return d;

      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.wednesday:
        return nearestSundayBefore(d);

      default:
        return nearestSundayAfter(d);
    }
  }
}
