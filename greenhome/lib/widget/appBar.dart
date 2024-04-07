import 'package:flutter/material.dart';
import 'package:greenhome/screen/home.dart';

class GreenHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isTransparent;

  const GreenHomeAppBar(
      {super.key, required this.title, this.isTransparent = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => home(context),
              ),
            );
          }
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 15.0,
              color: Colors.black54,
              offset: Offset(5.0, 5.0),
            ),
          ],
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
