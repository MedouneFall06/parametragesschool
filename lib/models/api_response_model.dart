class ApiResponse<T> {
  bool success;
  String message;
  T? data;
  List<T>? items;
  int? total;
  int? page;
  int? perPage;
  dynamic errors;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.items,
    this.total,
    this.page,
    this.perPage,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
      items: fromJsonT != null && json['items'] != null
          ? List<T>.from(json['items'].map((x) => fromJsonT(x)))
          : null,
      total: json['total'],
      page: json['page'],
      perPage: json['per_page'],
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson(Object? Function(T)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : null,
      'items': items != null && toJsonT != null
          ? List<dynamic>.from(items!.map((x) => toJsonT(x)))
          : null,
      'total': total,
      'page': page,
      'per_page': perPage,
      'errors': errors,
    };
  }
}