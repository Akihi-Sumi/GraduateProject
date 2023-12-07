import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduate_app/models/item/item_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItem({required String userId});
  Future<String> createItem({required String userId, required Item item});
  //Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItemMap(
      {required String userId, required String itemName});
}

final itemRepositoryProvider =
    Provider<ItemRepository>((ref) => ItemRepository());

class ItemRepository implements BaseItemRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Item> processData(dynamic listData) {
    // Firestoreからのデータがリストかどうか確認
    if (listData is List) {
      // リストからItemクラスのリストに変換
      List<Item> items = listData.map((item) {
        // FirestoreからのデータをItemインスタンスに変換
        return Item(
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
  Future<List<Item>> retrieveItem({required String userId}) async {
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
      {required String userId, required Item item}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw CustomException("User not logged in.");
    }

    try {
      final docRef = await _firestore
          .collection('appUsers')
          .doc(user.uid)
          .collection('survivalKits')
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(e.message ?? "Error creating item.");
    }
  }

  //@override
  Future<void> updateItemMap({
    required String userId,
    required String itemName, //list[name]
    required Item newItem, //newList
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

  Future<void> allItemCheckbox({
    required String userId,
    required String itemName,
    required bool isChecked,
  }) async {
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

          // Create a batch
          WriteBatch batch = FirebaseFirestore.instance.batch();

          // Iterate through each item and update its isChecked property in the batch
          for (int i = 0; i < list.length; i++) {
            // Create a new Map with existing properties and update only the isChecked property
            Map<String, dynamic> updatedItem = {
              ...list[i],
              'isChecked': isChecked,
            };

            // Update the list at the specific index with the updated item
            list[i] = updatedItem;

            batch.update(
              documentReference,
              {'list': list},
            );
          }

          // Commit the batch
          await batch.commit();
        } else {
          print('list field does not exist');
        }
      }
    } catch (e) {
      print('Error toggling all items checkbox: $e');
      throw CustomException('Error toggling all items checkbox: $e');
    }
  }

  Future<void> toggleItemCheckbox({
    required String userId,
    required String itemName,
    required bool isChecked,
  }) async {
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

          // Find the index of the item to update
          int index = list.indexWhere((item) => item['name'] == itemName);

          if (index != -1) {
            // Toggle the isChecked value
            list[index]['isChecked'] = isChecked;

            // Save the updated list back to Firestore
            await documentReference.update({'list': list});
          } else {
            print('Item not found in the list');
          }
        } else {
          print('list field does not exist');
        }
      }
    } catch (e) {
      print('Error toggling item checkbox: $e');
      throw CustomException('Error toggling item checkbox: $e');
    }
  }
}

class CurrentItemNotifier extends StateNotifier<Item?> {
  CurrentItemNotifier() : super(null);

  void setItem(Item item) {
    state = item;
  }
}
