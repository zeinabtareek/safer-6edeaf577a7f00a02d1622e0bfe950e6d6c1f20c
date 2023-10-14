import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/model/messages_model.dart';

class NotificationServices {
  final store = FirebaseFirestore.instance;

  Future<List<MessagesModel>> getAllMessages() async {
    final data = await store.collection("Messages").get();
    print("object${data.docs.length}");
    return data.docs.map((e) => MessagesModel.fromJSON(e)).toList();
  }
}
