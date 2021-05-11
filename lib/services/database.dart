import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future<void> updateUserData(String sugars, String name, int strength) async {
    try {
      return await brewCollection.doc(uid).set({
        'sugars': sugars,
        'name': name,
        'strength': strength,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }

  Future<dynamic> instatBrews() async {
    return await brewCollection.doc("277I6qjfl7eHa6f9rFvTYKhix4F2").get();
  }
}
