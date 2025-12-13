import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';

class FavoritesService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> _getDeviceId() async {
    final info = await DeviceInfoPlugin().androidInfo;
    return info.id;
  }

  Future<void> addFavorite(String mealId) async {
    final id = await _getDeviceId();

    await firestore
        .collection("favorites")
        .doc(id)
        .set({mealId: true}, SetOptions(merge: true));
  }

  Future<void> removeFavorite(String mealId) async {
    final id = await _getDeviceId();

    await firestore
        .collection("favorites")
        .doc(id)
        .update({mealId: FieldValue.delete()});
  }

  Future<List<String>> loadFavorites() async {
    try {
      final id = await _getDeviceId();
      final doc = await firestore.collection("favorites").doc(id).get();

      if (!doc.exists || doc.data() == null) {
        return [];
      }

      return doc.data()!.keys.toList();
    } catch (e) {
      print('Error loading favorites: $e');
      return [];
    }
  }
}