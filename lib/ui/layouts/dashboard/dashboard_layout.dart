import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/ui/shared/navbar.dart';
import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatefulWidget {

  //Los latout reciben un widget

  final Widget child;

  const DashboardLayout({
    Key? key,
    required this.child,
    }) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SideMenuProvider.menuController= new AnimationController(
      vsync:this,
      duration: Duration(microseconds: 300),
      );
  }

  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffEDF1F2),
        body: Stack(
          children: [
            Row(
              children:[
                  //TODO si es mas de 700 pixeles
                  if(size.width >= 700)
                  Sidebar(),
                  Expanded(
                    child: Column(
                    children: [
                    Navbar(),
                    Expanded(
                      child: Container(
                      //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: widget.child
                    )
                    ),
                    ],   
                    )
                  )
                  //Conetenedor de nuestra view el view es la pantalla basada en el url
              ]
            ),

            if(size.width < 700)
            AnimatedBuilder(
              animation: SideMenuProvider.menuController,
              builder: (context,_)=>Stack(
                children: [
                  //TODO Background
                  if (SideMenuProvider.isOpen)
                  AnimatedOpacity(
                    opacity: SideMenuProvider.opacity.value,
                    duration: Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () => SideMenuProvider.closeMenu(),
                      child: Container(
                        width: size.width,
                        height: size.height,
                        color: Colors.black26,

                      ),
                    ),
                    
                    ),

                  Transform.translate(offset: Offset(SideMenuProvider.movement.value,0),
                  child: Sidebar(),
                  )
                  //Sidebar()
                ],
              ))
          ],
        )

    );
  }
}