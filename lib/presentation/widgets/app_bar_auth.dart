import 'package:flutter/material.dart';

class AppBarAuth extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAuth({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color(0XffE8F1FD),
            shape: CircleBorder(),
          ),
          child: BackButton(
            color: Color(0Xff28303F),
          ),
        ),
      ),
    );
  }
}