import 'dart:developer';

import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  Future<void> loadCurrentUser() async {
    currentUser = await FirebaseServices.getCurrentUserModel();
    log('message');
    notifyListeners();
  }

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  void addEventToFav({required String eventId}) {
    FirebaseServices.addFavEvents(eventId: eventId);
    currentUser!.favEventsIds.add(eventId);
    notifyListeners();
  }

  void removeEventFromoFav({required String eventId}) {
    FirebaseServices.removeFavEvents(eventId: eventId);
    currentUser!.favEventsIds.remove(eventId);
    notifyListeners();
  }

  bool checkEventIsFav({required String eventId}) {
    return currentUser!.favEventsIds.contains(eventId);
  }
}
