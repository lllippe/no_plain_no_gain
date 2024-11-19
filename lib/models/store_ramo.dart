class StoreRamo {
  String ramo;

  StoreRamo({
    required this.ramo,
  });

  StoreRamo.empty()
      : ramo = '';

  StoreRamo.fromMap(Map<String, dynamic> map)
      : ramo = map['ramo'];

  @override
  String toString() {
    return "Ramo: $ramo";
  }

  Map<String, dynamic> toMap() {
    return {
      'ramo' : ramo,
    };
  }
}
