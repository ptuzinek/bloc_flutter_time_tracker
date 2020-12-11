import 'package:bloc_flutter_time_tracker/app/home_page.dart';
import 'package:bloc_flutter_time_tracker/app/services/auth.dart';
import 'package:bloc_flutter_time_tracker/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This LandingPage stores some STATE that will be used to decide
// if the SingInPage or the HomePage should be shown

// can use Boolean.
// We'll use instance of type User. User will be our state variable.
// Store User variable inside LandingPage and to decide what Page to show
// check if the User variable is null or not.

// We need a way for the SignInPage to tell LandingPage when user is singed in.
// We'll use callback. - but there is many other ways.

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return HomePage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    // // When app is started, User is null, so we see SignInPage. Once user
    // // singes in we trigger a callback to the LandingPage and it rebuilds to
    // // return HomePage.
    // // When we signOut we again trigger a callback and the LandingPage rebuilds
    // // and returns a SignInPage.
    // if (_user == null) {
    //   return SignInPage(
    //     auth: widget.auth,
    //     onSingIn: (user) => _updateUser(user),
    //   );
    // }
    // return HomePage(
    //   auth: widget.auth,
    //   // when we sing out we gonna call updateUser with null User
    //   // and in turn we'll update the internal STATE of the LandingPage
    //   // that will rebuild the LandingPage and return SingInPage instead of
    //   // HomePage
    //   onSingedOut: () => _updateUser(null),
    // );
  }
}
