import 'package:bloc_flutter_time_tracker/app/home_page.dart';
import 'package:bloc_flutter_time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This LandingPage stores some STATE that will be used to decide
// if the SingInPage or the HomePage should be shown

// can use Boolean.
// We'll use instance of type User. User will be our state variable.
// Store User variable inside LandingPage and to decide what Page to show
// check if the User variable is null or not.

// We need a way for the SignInPage to tell LandingPage when user is singed in.
// We'll use callback. - but there is many other ways.

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    // When app is started, User is null, so we see SignInPage. Once user
    // singes in we trigger a callback to the LandingPage and it rebuilds to
    // return HomePage.
    // When we signOut we again trigger a callback and the LandingPage rebuilds
    // and returns a SignInPage.
    if (_user == null) {
      return SignInPage(
        onSingIn: (user) => _updateUser(user),
      );
    }
    return HomePage(
      // when we sing out we gonna call updateUser with null User
      // and in turn we'll update the internal STATE of the LandingPage
      // that will rebuild the LandingPage and return SingInPage instead of
      // HomePage
      onSingedOut: () => _updateUser(null),
    );
  }
}
