class Grocery {
  final int? id;
  final String name;

  Grocery({this.id, required this.name});

  factory Grocery.fromMap(Map<String, dynamic> json) => Grocery(
        name: json['name'],
        id: json['id'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}
