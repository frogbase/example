// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStoreAdapter extends TypeAdapter<AuthStore> {
  @override
  final int typeId = 7;

  @override
  AuthStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthStore(
      user: fields[0] as User,
      tokens: fields[1] as Token,
    );
  }

  @override
  void write(BinaryWriter writer, AuthStore obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.tokens);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
