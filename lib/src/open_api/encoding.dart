part of openapi_models;

// ==========================================
// CLASS: Encoding
// ==========================================

/// Text
@freezed
class Encoding with _$Encoding {
  const factory Encoding({
    /// The Content-Type for encoding a specific property.
    String? contentType,
  }) = _Encoding;

  factory Encoding.fromJson(Map<String, dynamic> json) =>
      _$EncodingFromJson(json);
}
