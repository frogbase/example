part of '../extensions.dart';

extension StringUtils on String {
  bool get isEmail => _emailRegularExpression.hasMatch(toLowerCase());

  bool get isPhone => _phoneRegularExpression.hasMatch(toLowerCase());

  bool get isQatarPhone => _phoneQatarRegularExpression.hasMatch(toLowerCase());

  bool get isIpAddress => _ipAddressRegularExpression.hasMatch(toLowerCase());

  bool get isPortNumber => _portNumber.hasMatch(toLowerCase());

  bool get isPassword => length >= 6;

  bool get isUsername => !contains(' ') && length >= 4;

  bool get isNumeric => num.tryParse(this) != null;

  bool get isInt => int.tryParse(this) != null;

  int get wordCount => words.length;

  List<String> get words => split(' ');

  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  String get lowerCase => toLowerCase();

  String get upperCase => toUpperCase();

  String get trim => this.trim();

  int? get toInt => int.tryParse(trim);

  double? get toDouble => double.tryParse(trim);

  String get toCamelWord {
    final words = this.words;
    final firstWord = words.first;
    final restWords = words.sublist(1);
    final restWordsCapitalized = restWords.map((e) => e.capitalize);
    return '${firstWord.lowerCase}${restWordsCapitalized.join()}';
  }

  bool hasMatch(String v) => toLowerCase().contains(v.toLowerCase());
}

extension StringNullUtils on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  String firstWords(int n) {
    if (this == null || this!.isEmpty || n < 3) {
      return '';
    }

    final words = this!.split('');

    final firstNMinus3Words =
        words.length > n - 3 ? words.sublist(0, n - 3) : words;

    final result = firstNMinus3Words.join('');

    // If the input string has more words than the selected ones, add ellipsis
    if (words.length > n - 3) {
      return '$result...';
    } else {
      return this!;
    }
  }

  String get first50Words {
    if (this == null) return '';
    final words = this!.words;
    final first50Words = words.length > 50 ? words.sublist(0, 50) : words;
    return first50Words.join(' ');
  }

  String get first100Words {
    if (this == null) return '';
    final words = this!.words;
    final first50Words = words.length > 100 ? words.sublist(0, 100) : words;
    return first50Words.join(' ');
  }

  String get first200Words {
    if (this == null) return '';
    final words = this!.words;
    final first50Words = words.length > 200 ? words.sublist(0, 200) : words;
    return first50Words.join(' ');
  }
}

String pluralize(
  int number,
  String form1,
  String form2, [
  String? form3,
]) {
  final num = number % 100;

  if (num >= 11 && num <= 19) {
    return form3 ?? form2;
  }

  final i = num % 10;

  switch (i) {
    case 1:
      return form1;
    case 2:
    case 3:
    case 4:
      return form2;
    default:
      return form3 ?? form2;
  }
}

final RegExp _emailRegularExpression = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

final RegExp _phoneRegularExpression = RegExp(r'^[0-9]{11}$');

final RegExp _phoneQatarRegularExpression = RegExp(r'^[0-9]{8,25}$');

final RegExp _ipAddressRegularExpression = RegExp(
    r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');

final RegExp _portNumber = RegExp(r'^[0-9]{1,5}$');
