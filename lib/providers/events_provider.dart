import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/foundation.dart';

class EventsProvider with ChangeNotifier {
  List<EventModel> allEvents = [];
  List<EventModel> displayedEvents = [];
  List<EventModel> favoriteEvents = [];

  Future<void> getEvents() async {
    allEvents = await FirebaseServices.getEvents();
    displayedEvents = allEvents;
    notifyListeners();
  }

  void filterEvents(CategoryModel? category) {
    if (category == null) {
      displayedEvents = allEvents;
    } else {
      displayedEvents =
          allEvents.where((event) => event.category == category).toList();
    }
    notifyListeners();
  }

  void filterFavEvents(List<String> favoriteIds) {
    favoriteEvents =
        allEvents.where((event) => favoriteIds.contains(event.id)).toList();
    notifyListeners();
  }

  Future<void> addEvent(EventModel event) async {
    await FirebaseServices.createEvent(event);
    allEvents.add(event);
    notifyListeners();
  }

  Future<void> removeEvent({required String eventId}) async {
    await FirebaseServices.removeEventFromFireStore(eventId: eventId);
    allEvents.removeWhere((event) => event.id == eventId);
    favoriteEvents.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }
}
