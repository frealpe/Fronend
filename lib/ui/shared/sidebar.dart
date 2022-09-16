import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/widges/logo.dart';
import 'package:admin_dashboard/ui/shared/widges/menu_item.dart';
import 'package:admin_dashboard/ui/shared/widges/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Sidebar extends StatelessWidget {

  void navigateTo(String routeName){
      NavigationServer.replaceTo(routeName);
      SideMenuProvider.closeMenu();
  }

  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50,),
          TextSeparator(text: 'Principal'),

          MenuItemp(
            text:'Dashboard',
            icon:Icons.compass_calibration_outlined,
            isActive:sideMenuProvider.currentPage==Flurorouter.dashboardRoute,
            onPressed:()=> navigateTo(Flurorouter.dashboardRoute)           
          ),

          MenuItemp(
            text:'Categorias',
            icon:Icons.layers_outlined,
            isActive:sideMenuProvider.currentPage==Flurorouter.categoriesRoute,
            onPressed:()=> navigateTo(Flurorouter.categoriesRoute)
          ),

          MenuItemp(
            text:'Productos',
            icon:Icons.dashboard_outlined,
            isActive:sideMenuProvider.currentPage==Flurorouter.productosRoute,
            onPressed:()=> navigateTo(Flurorouter.productosRoute)           
            ),

          MenuItemp(text:'Clientes',
          icon:Icons.people_alt_outlined,
          isActive:sideMenuProvider.currentPage==Flurorouter.usersRoute,
          onPressed:()=> navigateTo(Flurorouter.usersRoute)
          ), 

          SizedBox(height: 50,), 
          TextSeparator(text: 'UI elements'),        
          MenuItemp(text:'Logout',icon:Icons.exit_to_app_outlined,onPressed:(){
            Provider.of<AuthProvider>(context,listen: false).logout();
          }),                                                                                            
        ],
      ),
    );
    
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 78, 29, 1),
        Color.fromARGB(255, 78, 29, 1),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        blurRadius: 10
      )
    ]
  );
}