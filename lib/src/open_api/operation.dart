part of openapi_models;

// ==========================================
// CLASS: Operation
// ==========================================

/// Describes a single API operation on a Path.
///
/// https://swagger.io/specification/#operation-object
@freezed
class Operation with _$Operation {
  const factory Operation({
    /// A list of tags for API documentation control.
    @JsonKey(toJson: _toJsonTags, fromJson: _fromJsonTags) List<Tag>? tags,

    /// A short summary of what the operation does.
    String? summary,

    /// An optional string describing the host designated by the URL.
    String? description,

    /// Additional external documentation for this schema.
    ExternalDocs? externalDocs,

    /// Unique string used to identify the operation.
    /// The id MUST be unique among all operations described in the API.
    @JsonKey(name: 'operationId') String? id,

    /// A list of parameters that are applicable for this operation.
    /// If a parameter is already defined at the [PathItem] level,
    /// the new definition will override it but can never remove it.
    List<Parameter>? parameters,

    /// The request body applicable for this operation.
    RequestBody? requestBody,

    /// The list of possible responses as they are returned from executing this operation.
    @_OperationResponseListConverter() List<Response>? responses,

    /// A map of possible out-of band callbacks related to the parent operation.
    /// The key is a unique identifier for the [ApiCallback] Object.
    List<ApiCallback>? callbacks,

    /// Declares this operation to be deprecated.
    bool? deprecated,

    /// A declaration of which security mechanisms can be used for this operation.
    /// The list of values includes alternative security requirement objects that can be used.
    List<Security>? security,

    /// An alternative [Server] array to service this operation.
    /// If an alternative [Server] object is specified at the [PathItem] level,
    /// it will be overridden by this value.
    List<Server>? servers,
  }) = _Operation;

  factory Operation.fromJson(Map<String, dynamic> json) =>
      _$OperationFromJson(json);
}

List<String>? _toJsonTags(List<Tag>? tags) {
  return tags?.map((e) => e.name).toList();
}

List<Tag>? _fromJsonTags(List<String>? json) {
  return json?.map((e) => Tag(name: e)).toList();
}

// ==========================================
// OperationResponseListConverter
// ==========================================

/// Custom converter for List<[Response]> union type
class _OperationResponseListConverter
    implements JsonConverter<List<Response>, Map<String, dynamic>> {
  const _OperationResponseListConverter();

  @override
  List<Response> fromJson(Map<String, dynamic> json) {
    return [];
  }

  @override
  Map<String, dynamic> toJson(List<Response> data) {
    Map<String, dynamic> json = {};
    for (final p in data) {
      p.map(
        (value) {
          json[value.code] = value.toJson()..remove('code');
        },
        reference: (value) {
          final r = value.ref;
          if (r is _Response) {
            json['\$ref'] = '#/components/responses/${r.id}';
          } else {
            throw Exception(
              '\n\nThe Response.reference() argument must not be another reference\n',
            );
          }
        },
      );
    }
    return json;
  }
}
