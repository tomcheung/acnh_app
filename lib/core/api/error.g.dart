// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
    json['error'] as String,
    json['errorCode'] as num,
  );
}

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('error', instance.error);
  writeNotNull('errorCode', instance.errorCode);
  return val;
}
