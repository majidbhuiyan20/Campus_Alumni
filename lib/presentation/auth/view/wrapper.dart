import 'package:campus_alumni/presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import 'package:campus_alumni/presentation/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check the snapshot state
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While checking auth state, show a loading indicator
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          print("Sign In with Google Successful");
          print("User Name: ${user.displayName}");
          print("User Email: ${user.email}");
          print("User UID: ${user.uid}");
          return  BottomNavBarScreen();
        } else {
          // User is not signed in
          return SplashScreen();
        }
      },
    );
  }
}
