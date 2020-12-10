import 'package:bloc_flutter_time_tracker/app/services/auth.dart';
import 'package:bloc_flutter_time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:bloc_flutter_time_tracker/app/sign_in/sign_in_button.dart';
import 'package:bloc_flutter_time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:bloc_flutter_time_tracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;

  void _updateLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseAuthException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in Failed', exception: exception);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      _updateLoadingState();
      final auth = Provider.of<AuthBase>(context, listen: false);
      // Here we add value to the Stream, because when we sign-in, Firebase
      // will emit new User type value to the authStateChanges Stream.
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
      _updateLoadingState();
    }
  }

  void _signInWithEmail(BuildContext context) {
    // Show EmailSignInPage
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: _buildContainer(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            text: 'Sign in with Google',
            assetName: 'images/google-logo.png',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: isLoading ? null : () {},
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            text: 'Sign in with Facebook',
            assetName: 'images/facebook-logo.png',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: isLoading ? null : () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go Anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

//
