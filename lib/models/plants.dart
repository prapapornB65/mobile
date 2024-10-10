class Plant {
  int? id;
  final String name;
  final String scientificName;
  final String type;
  final String habitat;
  final String shape;
  final bool hasFlowers;
  final double? flowerSize;
  final String? flowerColor;

  Plant({
    this.id,
    required this.name,
    required this.scientificName,
    required this.type,
    required this.habitat,
    required this.shape,
    required this.hasFlowers,
    this.flowerSize,
    this.flowerColor,
  });

  @override
  String toString() {
    return 'Plant{id: $id, name: $name, scientificName: $scientificName, type: $type, habitat: $habitat, shape: $shape, hasFlowers: $hasFlowers, flowerSize: $flowerSize, flowerColor: $flowerColor}';
  }
}
