import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:member_app/supports/convert.dart';


class _CupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'vi';

  @override
  Future<CupertinoLocalizations> load(Locale locale) => CupertinoMultiLocalizations.load(locale);

  @override
  bool shouldReload(_CupertinoLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultCupertinoLocalizations.delegate(vi_VN)';
}

/// US English strings for the cupertino widgets.
class CupertinoMultiLocalizations implements CupertinoLocalizations {
  /// Constructs an object that defines the cupertino widgets' localized strings
  /// for US English (only).
  ///
  /// [LocalizationsDelegate] implementations typically call the static [load]
  /// function, rather than constructing this class directly.
  const CupertinoMultiLocalizations();

  static const List<String> _shortWeekdays = <String>[
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
    'CN',
  ];

  static const List<String> _shortMonths = <String>[
    'Th1',
    'Th2',
    'Th3',
    'Th4',
    'Th4',
    'Th6',
    'Th7',
    'Th8',
    'Th9',
    'Th10',
    'Th11',
    'Th12',
  ];

  static const List<String> _months = <String>[
    'Tháng 1',
    'Tháng 2',
    'Tháng 3',
    'Tháng 4',
    'Tháng 5',
    'Tháng 6',
    'Tháng 7',
    'Tháng 8',
    'Tháng 9',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12',
  ];

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex) => dayIndex.toString();

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => "$hour giờ";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    return '$minute phút';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get alertDialogLabel => 'Info';

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? 'Stunde' : 'Stunden';

  @override
  String timerPickerMinuteLabel(int minute) => 'Phút';

  @override
  String timerPickerSecondLabel(int second) => 'Giây';

  @override
  String get cutButtonLabel => 'Ausschneiden';

  @override
  String get copyButtonLabel => 'Kopieren';

  @override
  String get pasteButtonLabel => 'Einfügen';

  @override
  String get selectAllButtonLabel => 'Alles auswählen';

  /// Creates an object that provides US English resource values for the
  /// cupertino library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  static Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(const CupertinoMultiLocalizations());
  }

  /// A [LocalizationsDelegate] that uses [DefaultCupertinoLocalizations.load]
  /// to create an instance of this class.
  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _CupertinoLocalizationsDelegate();

  @override
  // TODO: implement modalBarrierDismissLabel
  String get modalBarrierDismissLabel => 'modalBarrierDismissLabel';

  @override
  // TODO: implement searchTextFieldPlaceholderLabel
  String get searchTextFieldPlaceholderLabel => 'searchTextFieldPlaceholderLabel';

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    // TODO: implement tabSemanticsLabel
    return 'tabSemanticsLabel';
  }

  @override
  // TODO: implement timerPickerHourLabels
  List<String> get timerPickerHourLabels => ['Giờ'];

  @override
  // TODO: implement timerPickerMinuteLabels
  List<String> get timerPickerMinuteLabels => ['Phút'];

  @override
  // TODO: implement timerPickerSecondLabels
  List<String> get timerPickerSecondLabels => ['Giây'];

  @override
  // TODO: implement todayLabel
  String get todayLabel => dateToString(DateTime.now(), 'dd/MM/yyyy');
}