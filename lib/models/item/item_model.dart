import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String expirationDate;
  final String name;
  bool isChecked;
  final int time;

  Item({
    required this.expirationDate,
    required this.name,
    required this.isChecked,
    required this.time,
  });

  Item copyWith({
    String? expirationDate,
    String? name,
    bool? isChecked,
    int? time,
  }) {
    return Item(
      expirationDate: expirationDate ?? this.expirationDate,
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
      time: time ?? this.time,
    );
  }

  // Create an item from a Firestore document
  factory Item.fromDocument(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      expirationDate: data['expirationDate'] as String,
      name: data['name'] as String,
      isChecked: data['isChecked'] as bool,
      time: data['time'] as int,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'expirationDate': expirationDate,
      'name': name,
      'isChecked': isChecked,
      'time': time,
    };
  }
}
