import 'package:bloc_flutter_time_tracker/app/services/auth.dart';
import 'package:bloc_flutter_time_tracker/common_widgets/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signInOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      // Here we add value to the Stream, because when we sign-in, Firebase
      // will emit new User type value to the authStateChanges Stream.
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'logout',
        content: 'Are You sure that you want to logout?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Logout');

    if (didRequestSignOut == true) {
      _signInOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
