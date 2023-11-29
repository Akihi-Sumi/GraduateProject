import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    @Default('') String itemId,
    @Default('') String expirationDate,
    @Default('') String name,
    @Default(false) bool isChecked,
    @Default(0) int time,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  factory ItemModel.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;

    return ItemModel.fromJson(<String, dynamic>{
      ...data,
      'itemId': ds.id,
    });
  }

  const ItemModel._();
}
