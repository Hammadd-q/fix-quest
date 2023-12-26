class ErrorResponse {
  List<String> _errors = List.empty(growable: true);

  List<String> get errors => _errors;

  ErrorResponse({required List<String> errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        _errors.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors.isNotEmpty) {
      map["errors"] = _errors.toList();
    }
    return map;
  }
}
