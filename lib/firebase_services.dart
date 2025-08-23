import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static CollectionReference<EventModel> getEventsCollections() =>
      FirebaseFirestore.instance.collection('events').withConverter<EventModel>(
          fromFirestore: (docSnapshot, _) =>
              EventModel.fromJson(docSnapshot.data()!),
          toFirestore: (event, _) => event.toJson());

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventsCollection = getEventsCollections();
    DocumentReference<EventModel> eventDoc = eventsCollection.doc();
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> collectionEvents = getEventsCollections();
    QuerySnapshot<EventModel> querySnapshot =
        await collectionEvents.orderBy('timestamp').get();
    return querySnapshot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }

  static CollectionReference<UserModel> getUsersCollections() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
          fromFirestore: (docSnapshot, _) =>
              UserModel.fromJson(docSnapshot.data()!),
          toFirestore: (user, _) => user.toJson());

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserModel user = UserModel(
        email: email, name: name, id: credential.user!.uid, favEventsIds: []);

    CollectionReference<UserModel> collectionUsers = getUsersCollections();
    await collectionUsers.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> collectionUsers = getUsersCollections();

    DocumentSnapshot<UserModel> docSnapshot =
        await collectionUsers.doc(userCredential.user!.uid).get();
    return docSnapshot.data()!;
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  Future<void> addFavEvents({required String eventId}) {
    CollectionReference<UserModel> collectionUsers = getUsersCollections();
    DocumentReference<UserModel> userDoc =
        collectionUsers.doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.update(
      {
        'favEventsIds':FieldValue.arrayUnion([eventId])
      }
    );
  }

  Future<void> removeFavEvents({required String eventId}) {
    CollectionReference<UserModel> collectionUsers = getUsersCollections();
    DocumentReference<UserModel> userDoc =
        collectionUsers.doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.update(
      {
        'favEventsIds':FieldValue.arrayRemove([eventId])
      }
    );
  }

}
