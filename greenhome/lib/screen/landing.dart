import 'package:flutter/material.dart';
import 'package:greenhome/screen/home.dart'; // Ensure this import is correct

class LandingScreen extends StatefulWidget {
  final BuildContext context;
  const LandingScreen({super.key, required this.context});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the callback to run after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigate after a 2-second delay
      Future.delayed(const Duration(seconds: 3), () {
        // Use pushReplacement to replace the current route with the home route
        // This prevents the user from going back to the splash screen with the back button
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => home(context)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Image(
        image: AssetImage('asset/images/SP_LandingImage.png'),
      ),
    );
  }
}
