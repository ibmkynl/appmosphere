// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentWeatherModelAdapter extends TypeAdapter<CurrentWeatherModel> {
  @override
  final int typeId = 0;

  @override
  CurrentWeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentWeatherModel(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      weatherId: fields[2] as int,
      mainWeather: fields[3] as String,
      description: fields[4] as String,
      iconCode: fields[5] as String,
      temperature: fields[6] as double,
      feelsLike: fields[7] as double,
      tempMin: fields[8] as double,
      tempMax: fields[9] as double,
      pressure: fields[10] as int,
      humidity: fields[11] as int,
      seaLevel: fields[12] as int?,
      groundLevel: fields[13] as int?,
      visibility: fields[14] as int,
      windSpeed: fields[15] as double,
      windDegree: fields[16] as int,
      cloudiness: fields[17] as int,
      dateTime: fields[18] as int,
      country: fields[19] as String,
      sunrise: fields[20] as int,
      sunset: fields[21] as int,
      timezone: fields[22] as int,
      cityId: fields[23] as int,
      cityName: fields[24] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherModel obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.weatherId)
      ..writeByte(3)
      ..write(obj.mainWeather)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.iconCode)
      ..writeByte(6)
      ..write(obj.temperature)
      ..writeByte(7)
      ..write(obj.feelsLike)
      ..writeByte(8)
      ..write(obj.tempMin)
      ..writeByte(9)
      ..write(obj.tempMax)
      ..writeByte(10)
      ..write(obj.pressure)
      ..writeByte(11)
      ..write(obj.humidity)
      ..writeByte(12)
      ..write(obj.seaLevel)
      ..writeByte(13)
      ..write(obj.groundLevel)
      ..writeByte(14)
      ..write(obj.visibility)
      ..writeByte(15)
      ..write(obj.windSpeed)
      ..writeByte(16)
      ..write(obj.windDegree)
      ..writeByte(17)
      ..write(obj.cloudiness)
      ..writeByte(18)
      ..write(obj.dateTime)
      ..writeByte(19)
      ..write(obj.country)
      ..writeByte(20)
      ..write(obj.sunrise)
      ..writeByte(21)
      ..write(obj.sunset)
      ..writeByte(22)
      ..write(obj.timezone)
      ..writeByte(23)
      ..write(obj.cityId)
      ..writeByte(24)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentWeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
