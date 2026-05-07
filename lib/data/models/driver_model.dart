import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/driver.dart';

part 'driver_model.freezed.dart';
part 'driver_model.g.dart';

@freezed
class DriverModel with _$DriverModel {
  const factory DriverModel({
    required String name,
    required String car,
    required String plate,
    String? photo,
  }) = _DriverModel;

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  const DriverModel._();
  Driver toEntity() => Driver(
        name: name,
        car: car,
        plate: plate,
        photo: photo,
      );
}