class Result extends Object {
  final String title;
  final String id;

  Result({required this.title, required this.id});

  @override
  bool operator ==(Object other) {
    return other is Result && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '{ id: $id, title: $title }';
}
