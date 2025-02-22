import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';

class ResponseApiModel<T> extends ResponseApi {
  ResponseApiModel({
    required super.status,
    required super.message,
    super.data,
  });

  factory ResponseApiModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    final data = json['data'];
    T? deserializedData;
    if (data != null) {
      if (data is Map<String, dynamic>) {
        deserializedData = fromJson(data);
      } else if (data is List<dynamic>) {
        deserializedData = data.map((item) => fromJson(item)).toList() as T;
      } else {
        throw FormatException('Unexpected data type: $data');
      }
    }
    return ResponseApiModel(
      status: json['status'],
      message: json['message'],
      data: deserializedData,
    );
  }

  factory ResponseApiModel.fromListJson(
    Map<String, dynamic> json,
    T Function(List<dynamic>) fromJsonList,
  ) {
    final data = json['data'];

    T? deserializedData;

    if (data != null && data is List<dynamic>) {
      deserializedData = fromJsonList(data);
    }
    return ResponseApiModel<T>(
      status: json['status'] as int,
      message: json['message'] as String,
      data: deserializedData,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data,
    };
  }

  ResponseApiModel copyWith({
    int? status,
    String? message,
    T? data,
  }) {
    return ResponseApiModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
