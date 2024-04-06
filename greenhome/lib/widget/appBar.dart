import 'package:flutter/material.dart';

class GreenHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isTransparent;

  const GreenHomeAppBar(
      {super.key, required this.title, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:
          isTransparent ? Colors.transparent : Theme.of(context).primaryColor,
      elevation: isTransparent ? 0 : 5.0,
      // Add other properties as needed
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
