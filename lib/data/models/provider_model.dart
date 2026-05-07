import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/provider.dart';

part 'provider_model.freezed.dart';
part 'provider_model.g.dart';

@freezed
class ProviderModel with _$ProviderModel {
  const factory ProviderModel({
    required String name,
    String? category,
    String? logo,
  }) = _ProviderModel;

  factory ProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderModelFromJson(json);

  const ProviderModel._();
  ProviderInfo toEntity() => ProviderInfo(
        name: name,
        category: category,
        logo: logo,
      );
}