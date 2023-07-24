final class Arguments {
  final Map<String, dynamic>? params;
  final dynamic data;

  Arguments({this.params = const {}, this.data});

  Arguments copyWith({Map<String, dynamic>? params, dynamic data}) => Arguments(
        params: params ?? this.params,
        data: data ?? this.data,
      );
}
