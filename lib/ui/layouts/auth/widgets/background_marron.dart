import 'package:flutter/material.dart';

//Eqauivalente a BackgroundTwitter

class BackgroundMarron extends StatelessWidget {
  const BackgroundMarron({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
            child: Container(
            decoration: buildBoxDecoration(),
            child: Container(              
                constraints: BoxConstraints(maxWidth: 400),
                child: Center(
                  child: Container(
                    //TODO SE PUEDE MODIFICAR
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:30),
                      child: Image(
                      image: AssetImage('marron_fondo.jpg'),
                      width: 1000,
                      ),
                    ),
                  )
                ),
             ),
            )
          );
  }

  BoxDecoration buildBoxDecoration() {

    //Decoration no es compatible con el color
    return BoxDecoration(
             image: DecorationImage(
              image: AssetImage('fondo-tala.jpeg'),
              fit: BoxFit.cover,
              ),
            border: Border.all(
                color: Colors.black,
                width: 8,
              ), 
 //              borderRadius: BorderRadius.circular(12),           
          );
  }
}