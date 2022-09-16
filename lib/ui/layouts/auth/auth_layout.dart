//Pagina de autenticación del usuario

import 'package:admin_dashboard/ui/layouts/auth/widgets/background_marron.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/custom_title.dart';
import 'package:admin_dashboard/ui/layouts/auth/widgets/links_bar.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {


  final Widget child;

  const AuthLayout({
    Key? key,
    required this.child
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            (size.width > 1000)?
            _DesktopBody(child:child)
            :_MobileBody(child:child),
            LinksBar(),
          ],
      
        ),
      )
    );
  }
}
///////////////////////////////////////////////////////////////
//Cuerpo del Desktop
class _DesktopBody extends StatelessWidget {

  final Widget child;
  const _DesktopBody({
    Key? key,
    required this.child
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Se toma todo el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height*0.95,
      color: Colors.white,
       child: Row(
        children: [
          //TODO 
          BackgroundMarron(),
         //La vista basade en Url 
         Container(
          width: 600,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
                SizedBox(height: 20),
                CustomTitle(),
                SizedBox(height: 50),
                Expanded(child: child)        //Entra la primera ruta de la pagian '/' la cual proviene del router child es LoginView();
            ],
            ),
          //child
         )
        ],
       ), 
    );
    
  }
}

//Cuerpo del Mobile
class _MobileBody extends StatelessWidget {

    final Widget child;
  const _MobileBody({
    Key? key,
    required this.child
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CustomTitle(),
          Container(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          Container(
            width: double.infinity,
            height: 400,
            child: BackgroundMarron(),
          )
        ],
      ),
    );
  }
}
//Cuerpo del Mensajes