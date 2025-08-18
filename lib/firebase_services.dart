import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';

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
}
