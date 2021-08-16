import 'package:flutter/cupertino.dart';

class TransitionAuth extends ChangeNotifier {
  String provider = 'unknown';

  void transitionAuth(String selectAuth){
    provider = selectAuth;
    notifyListeners();
  }
}
