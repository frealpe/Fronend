import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('marron_logo.jpeg',
          width: 150,
          height: 150),
          SizedBox(height: 20),
          FittedBox(
           alignment: Alignment.center,
            fit: BoxFit.contain,
            child: Text(
              'Todo en Artículos de Cuero',
              style: GoogleFonts.montserratAlternates(
                  fontSize:60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ]
      ),
    );
  }
}