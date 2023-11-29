import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduate_app/models/item/item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

abstract class BaseItemRepository {
  Future<List<ItemModel>> retrieveItem({required String userId});
  Future<String> createItem({required String userId, required ItemModel item});
  //Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItemMap(
      {required String userId, required String itemName});
}

final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository());

class ItemRepository implements BaseItemRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ItemModel> processData(dynamic listData) {
    // Firestoreからのデータがリストかどうか確認
    if (listData is List) {
      // リストからItemクラスのリストに変換
      List<ItemModel> items = listData.map((item) {
        // FirestoreからのデータをItemインスタンスに変換
        return ItemModel(
          expirationDate: item['expirationDate'],
          name: item['name'],
          isChecked: item['isChecked'],
          time: item['time'],
        );
      }).toList();

      return items;
    } else {
      // データが想定通りの形式でない場合のエラーハンドリング
      throw CustomException('Invalid data format');
    }
  }

  //@override
  Future<bool> doesItemExist(String userId, String itemName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData')
          .get();

      if (querySnapshot.exists) {
        final listData = querySnapshot.data();
        if (listData!.containsKey('list')) {
          List<dynamic> list = listData['list'];
          return list.any((item) => item['name'] == itemName);
        } else {
          print('list field does not exist');
          return false;
        }
      } else {
        print('listData does not exist');
        return false;
      }
    } catch (e) {
      print('Error checking item existence: $e');
      throw CustomException('Error checking item existence: $e');
    }
  }

  @override
  Future<List<ItemModel>> retrieveItem({required String userId}) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData')
          .get();

      // 以下はデータを処理する部分
      if (querySnapshot.exists) {
        final listData = querySnapshot.data(); // データを取得する
        // 必要な処理を実行
        return processData(listData); // 例えば、データを処理した結果を返す
      } else {
        print('listData does not exist');
        return []; // もしくは空のリストなど、適切なデフォルト値を返す
      }
    } catch (e) {
      print('Error fetching listData: $e');
      throw CustomException('Error fetching listData: $e'); // エラーを投げる
    }
  }

  @override
  Future<String> createItem(
      {required String userId, required ItemModel item}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw CustomException("User not logged in.");
    }

    try {
      final docRef = await _firestore
          .collection('appUsers')
          .doc(user.uid)
          .collection('survivalKits')
          .add(item.toJson());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Error creating item.");
    }
  }

  //@override
  Future<void> updateItemMap({
    required String userId,
    required String itemName, //list[name]
    required ItemModel newItem, //newList
  }) async {
    try {
      final DocumentReference documentReference = FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData');

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final DocumentSnapshot snapshot =
            await transaction.get(documentReference);

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          if (data.containsKey('list')) {
            List<Map<String, dynamic>> list =
                (data['list'] as List<dynamic>).cast<Map<String, dynamic>>();

            // Find the index of the item to update
            int index = list.indexWhere((item) => item['name'] == itemName);

            if (index != -1) {
              // Update the item at the found index with the new data
              list[index]['expirationDate'] = newItem.expirationDate;
              list[index]['name'] = newItem.name;

              // Save the updated list back to Firestore
              transaction.update(documentReference, {'list': list});
            } else {
              print('Item not found in the list');
            }
          } else {
            print('list field does not exist');
          }
        }
      });
    } catch (e) {
      print('Error updating map entry: $e');
      throw CustomException('Error updating map entry: $e');
    }
  }

  @override
  Future<void> deleteItemMap(
      {required String userId, required String itemName}) async {
    try {
      final DocumentReference documentReference = FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData');

      final DocumentSnapshot documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey('list')) {
          List<dynamic> list = data['list'] as List<dynamic>;

          // ここでitemNameに該当する要素を削除
          list.removeWhere((item) => item['name'] == itemName);

          // 更新後のリストを Firestore に再保存
          await documentReference.update({'list': list});
        } else {
          print('list field does not exist');
        }
      }
    } catch (e) {
      print('Error deleting map entry: $e');
      throw CustomException('Error deleting map entry: $e');
    }
  }
}

class CurrentItemNotifier extends StateNotifier<ItemModel?> {
  CurrentItemNotifier() : super(null);

  void setItem(ItemModel item) {
    state = item;
  }
}
