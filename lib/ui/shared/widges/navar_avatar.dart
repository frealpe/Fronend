import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network('/assets/marron_fondo.jpg',
      width: 30,
      height: 30,
      ),
    );
  }
}