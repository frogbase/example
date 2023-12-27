part of 'settings.model.dart';

extension SettingExtension on AppSettings {
  AppSettings copyWith({
    bool? firstRun,
    String? baseUrl,
    String? currency,
    String? dateFormat,
    String? timeFormat,
    String? fontFamily,
    ThemeProfile? theme,
    int? posPrinterPort,
    LocaleProfile? locale,
    String? currencyFormat,
    bool? useSecureProtocol,
    DateTime? firstRunDateTime,
    String? posPrinterIpAddress,
    bool? performanceOverlayEnable,
  }) =>
      AppSettings()
        ..performanceOverlayEnable = performanceOverlayEnable ?? this.performanceOverlayEnable
        ..useSecureProtocol = useSecureProtocol ?? this.useSecureProtocol
        ..firstRunDateTime = firstRunDateTime ?? this.firstRunDateTime
        ..dateFormat = dateFormat ?? this.dateFormat
        ..timeFormat = timeFormat ?? this.timeFormat
        ..fontFamily = fontFamily ?? this.fontFamily
        ..currency = currency ?? this.currency
        ..firstRun = firstRun ?? this.firstRun
        ..baseUrl = baseUrl ?? this.baseUrl
        ..locale = locale ?? this.locale
        ..theme = theme ?? this.theme;

  DateFormat get getDateFormat => DateFormat(dateFormat);

  DateFormat get getTimeFormat => DateFormat(timeFormat);

  DateFormat get getDateTimeFormat => DateFormat('$dateFormat $timeFormat');

}
