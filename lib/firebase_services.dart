import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    CollectionReference<UserModel> collectionUsers = getUsersCollections();

    DocumentSnapshot<UserModel> documentSnapshot =
        await collectionUsers.doc(userCredential.user!.uid).get();
    if (documentSnapshot.exists) {
      return documentSnapshot.data()!;
    } else {
      UserModel user = UserModel(
          email: userCredential.user!.email!,
          name: userCredential.user!.displayName!,
          id: userCredential.user!.uid,
          favEventsIds: []);
      await collectionUsers.doc(userCredential.user!.uid).set(user);
      return user;
    }
  }

  static Future<void> logout() {
    return FirebaseAuth.instance.signOut();
  }

  static Future<UserModel?> getCurrentUserModel() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }
    CollectionReference<UserModel> userCollections = getUsersCollections();
    DocumentSnapshot<UserModel> documentSnapshot =
        await userCollections.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return documentSnapshot.data();
  }

  static Future<void> addFavEvents({required String eventId}) {
    CollectionReference<UserModel> collectionUsers = getUsersCollections();
    DocumentReference<UserModel> userDoc =
        collectionUsers.doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.update({
      'favEventsIds': FieldValue.arrayUnion([eventId])
    });
  }

  static Future<void> removeFavEvents({required String eventId}) {
    CollectionReference<UserModel> collectionUsers = getUsersCollections();
    DocumentReference<UserModel> userDoc =
        collectionUsers.doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.update({
      'favEventsIds': FieldValue.arrayRemove([eventId])
    });
  }

  static Future<void> removeEventFromFireStore({required String eventId}) async{
    CollectionReference<EventModel> eventsCollection = getEventsCollections();
    await eventsCollection.doc(eventId).delete();
  }
}
