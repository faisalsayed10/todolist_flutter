import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createTodo(String title) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("todos").doc();

    await documentReference.set(
        {"title": title, "is_completed": false, "created_at": DateTime.now()});
  } catch (e) {
    print(e.toString());
  }
}

Future<void> updateTodo(String id) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("todos").doc(id);

    var snapshot = await documentReference.get();
    if (!snapshot.exists) return;
    var data = snapshot.data() as Map;

    documentReference.update({
      "title": data['title'],
      "is_completed": !data['is_completed'],
      "created_at": data['created_at']
    });
  } catch (e) {
    print(e.toString());
  }
}

Future<void> deleteTodo(String id) async {
  try {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("todos").doc(id);

    await documentReference.delete();
  } catch (e) {
    print(e.toString());
  }
}
