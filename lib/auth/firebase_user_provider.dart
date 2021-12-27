import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Model2FirebaseUser {
  Model2FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Model2FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Model2FirebaseUser> model2FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Model2FirebaseUser>((user) => currentUser = Model2FirebaseUser(user));
