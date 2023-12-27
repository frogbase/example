// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 4;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings()
      ..firstRun = fields[0] as bool
      ..currency = fields[1] as String
      ..useSecureProtocol = fields[2] as bool
      ..performanceOverlayEnable = fields[3] as bool
      ..dateFormat = fields[4] as String
      ..timeFormat = fields[5] as String
      ..theme = fields[6] as ThemeProfile
      ..locale = fields[7] as LocaleProfile
      ..firstRunDateTime = fields[8] as DateTime
      ..fontFamily = fields[9] as String
      ..baseUrl = fields[10] as String;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.firstRun)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.useSecureProtocol)
      ..writeByte(3)
      ..write(obj.performanceOverlayEnable)
      ..writeByte(4)
      ..write(obj.dateFormat)
      ..writeByte(5)
      ..write(obj.timeFormat)
      ..writeByte(6)
      ..write(obj.theme)
      ..writeByte(7)
      ..write(obj.locale)
      ..writeByte(8)
      ..write(obj.firstRunDateTime)
      ..writeByte(9)
      ..write(obj.fontFamily)
      ..writeByte(10)
      ..write(obj.baseUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
